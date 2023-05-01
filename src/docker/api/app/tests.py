import unittest
import blobstorage
import enrollment
import Database

class Tests(unittest.TestCase):
    def test_create_file_url(self):
        result = blobstorage.create_file_url('test.pdf', 1234567890123)
        expected = 'test-1234567890123.pdf'
        self.assertEqual(result, expected, 'Wrong file url')

    def test_create_file(self):
        result = blobstorage.create_file('test.pdf', None, 'test-1234567890123.pdf', None, '2023-01-01 10:00:00')
        expected = True
        self.assertNotEqual(result, expected, 'Database is inserting wrong data')

    def test_read_file_url(self):
        result = blobstorage.read_file_url(-1)
        expected = Exception
        self.assertIsInstance(result, expected, 'Wrong PK management')

    def test_read_filename(self):
        result = blobstorage.read_filename(-1)
        expected = Exception
        self.assertIsInstance(result, expected, 'Wrong PK management')

    def test_read_latest_files(self):
        result = blobstorage.read_latest_files('test')
        expected = []
        self.assertEqual(result, expected, 'Retrieving wrong info')

    def test_read_file_history(self):
        result = blobstorage.read_file_history(-1)
        expected = []
        self.assertEqual(result, expected, 'Retrieving wrong info')

    def test_update_file_description(self):
        result = blobstorage.update_file_description(-1, 'test')
        expected = True
        self.assertEqual(result, expected, 'Update does not work')

    def test_delete_file(self):
        result = blobstorage.delete_file(-1)
        expected = True
        self.assertEqual(result, expected, 'Delete does not work')

    def test_current_enrollment_time(self):
        enrollment_period_id = 1  
        expected_result = 10  
        result = enrollment.current_enrollment_time(enrollment_period_id)
        self.assertEqual(result, expected_result, f'Error: se esperaba {expected_result}, se obtuvo {result}')

    def test_current_enrollment_time_with_nonexistent_id(self):
        enrollment_period_id = -1  
        expected_result = Exception
        result = enrollment.current_enrollment_time(enrollment_period_id)
        self.assertIsInstance(result, expected_result, f'Error: se esperaba {expected_result}, se obtuvo {result}')
    
    def test_read_all_enrollments_by_student_id(self):
        result = enrollment.read_all_enrollments_by_student_id('123456')
        self.assertIsInstance(result, list, 'Result should be a list')
        self.assertGreater(len(result), 0, 'Result should not be empty')

        with self.assertRaises(Exception):
            enrollment.read_all_enrollments_by_student_id('invalid_id')

    def test_check_schedule_clash(self):

        result = enrollment.check_schedule_clash('new_class_id', 'student_id')
        self.assertIsInstance(result, list, 'Result should be a list')
        self.assertEqual(len(result), 0, 'Result should be empty')

        with self.assertRaises(Exception):
            enrollment.check_schedule_clash('clashing_class_id', 'student_id')
    
    def test_calculate_period_average(self):
        result = enrollment.calculate_period_average('valid_student_id')
        self.assertIsInstance(result, int, 'Result should be an integer')
        self.assertGreaterEqual(result, 0, 'Result should be greater than or equal to 0')

        with self.assertRaises(Exception):
            enrollment.calculate_period_average('invalid_student_id')

    def test_calculate_enrollment_hour_by_student_id(self):
        student_id = '12345'
        enrollment_period_id = '67890'
        expected_enrollment_hour = 2
      
        enrollment_hour = enrollment.calculate_enrollment_hour_by_student_id(student_id, enrollment_period_id)

        self.assertEqual(enrollment_hour, expected_enrollment_hour, 
                         f'Error: El resultado obtenido {enrollment_hour} es diferente al esperado {expected_enrollment_hour}.')

    def test_read_all_enrollment_available_courses_by_student_id(self):
        studentID = '123'
        enrollment_period_id = 456
        expected_output = [{'id': 1, 'name': 'Course A'}, {'id': 2, 'name': 'Course B'}]
        result = enrollment.read_all_enrollment_available_courses_by_student_id(studentID, enrollment_period_id)
        self.assertEqual(result, expected_output)

        studentID = '123'
        enrollment_period_id = 'invalid'
        expected_output = ValueError("invalid literal for int() with base 10: 'invalid'")
        result = enrollment.read_all_enrollment_available_courses_by_student_id(studentID, enrollment_period_id)
        self.assertEqual(result, expected_output)

        studentID = None
        enrollment_period_id = 456
        expected_output = AttributeError("'NoneType' object has no attribute 'execute'")
        result = enrollment.read_all_enrollment_available_courses_by_student_id(studentID, enrollment_period_id)
        self.assertEqual(result, expected_output)

        studentID = None
        enrollment_period_id = None
        expected_output = AttributeError("'NoneType' object has no attribute 'execute'")
        result = enrollment.read_all_enrollment_available_courses_by_student_id(studentID, enrollment_period_id)
        self.assertEqual(result, expected_output)

unittest.main()

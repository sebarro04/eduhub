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

unittest.main()

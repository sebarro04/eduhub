<template>
    <h1 class="h1" id="test">Archivos Subidos</h1>

    <div>
        <table class="latest-files-table" id="latest_files_tbl">
            <thead>
                <tr>
                    <td><b>Nombre</b></td>
                    <td><b>Descripción</b></td>
                    <td><b>Fecha de creación</b></td>
                    <td><b>Última fecha de modificación</b></td>
                </tr>
            </thead>
            <tbody>
                <tr v-for="file in files" :key="file.id">
                    <td>{{file.name}}</td>
                    <td>{{file.description}}</td>
                    <td>{{file.creation_datetime}}</td>
                    <td>{{file.last_modified_datetime}}</td>
                    <td><button type="button" class="btn">Descargar</button></td>
                    <a href="FileHistoy.vue"><td><button type="button" class="btn">Ver historial</button></td></a>
                    <td><button type="button" class="btn">Eliminar</button></td>
                </tr>
            </tbody>
        </table>
    </div>
    <button type="button" class="btn" id="upload_btn">Subir archivo</button>
</template>

<script>

export default {
    data: () => ({
        files: [
            {
                id: 1,
                name: 'file',
                description: 'test',
                creation_datetime: '2023-01-01 10:00:00',
                last_modified_datetime: null
            }
        ]
    })
}    

</script>
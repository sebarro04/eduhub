<template>
    <h1>Historial del archivo</h1>

    <div>
        <table class="file-history-table">
            <thead>
                <tr>
                    <td>Nombre</td>
                    <td>Descripción</td>
                    <td>Fecha de creación</td>
                    <td>Última fecha de modificación</td>
                </tr>
            </thead>
            <tbody>
                {{#each files}}
                <tr>
                    <td>{{this.name}}</td>
                    <td>{{this.description}}</td>
                    <td>{{this.creation_datetime}}</td>
                    <td>{{this.last_modified_datetime}}</td>
                    <td><button type="button">Descargar</button></td>
                </tr>
            </tbody>
        </table>
    </div>
</template>
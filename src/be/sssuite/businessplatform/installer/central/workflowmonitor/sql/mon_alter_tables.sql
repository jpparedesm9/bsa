/* Modifica las tablas historicas de workflow */

use cob_workflow
go

/* Se agrega la columna para almacenar el tiempo máximo de un proceso completado */
--alter table wf_r_proceso
    --add rr_tiempo_max int null
--go

/* Se agrega la columna para almacenar el tiempo máximo de una tarea completada */
--alter table wf_r_actividades_proc
    --add da_tiempo_max int null
--go

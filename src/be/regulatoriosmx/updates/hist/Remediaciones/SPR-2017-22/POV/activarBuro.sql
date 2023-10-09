---------------------------------------------------
------- Actualizar campo para consutla buro -------
---------------------------------------------------

use cobis
go


/* para pruebas de consulta real con 1 */
UPDATE cobis..cl_parametro
SET pa_int = 0
WHERE pa_nemonico = 'OBCDS'

/* para pruebas de Santander real con 1 */
UPDATE cobis..cl_parametro
SET pa_int = 1
WHERE pa_nemonico = 'SIMSAN'



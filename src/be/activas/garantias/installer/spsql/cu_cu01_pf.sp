/************************************************************************/
/*    Archivo:                cu_cu01_pf.sp                             */
/*    Stored procedure:       sp_cu01_pf                                */
/*    Base de datos:          cob_custodia                              */
/*    Producto:               Custodias                                 */
/************************************************************************/
/*                             IMPORTANTE                               */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "COBISCORP".                                                      */
/*    Su uso no autorizado  queda  expresamente  prohibido asi como     */
/*    cualquier  alteracion  o  agregado  hecho  por  alguno de sus     */
/*    usuarios  sin  el  debido  consentimiento  por  escrito de la     */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Despliega para las pantallas de perfiles contables en el modulo   */
/*    de Contabilidad COBIS los valores que pueden tomar los criterios  */
/*    contables de CLASE CARTERA , TIPO GARANTIA y ESTADO GARANTIA      */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/************************************************************************/


use cob_custodia
go

if exists (select 1 from sysobjects where id = object_id('sp_cu01_pf'))
    drop proc sp_cu01_pf
go

create proc sp_cu01_pf(
@i_criterio tinyint     = null,
@i_codigo   varchar(30) = null)

as

declare
@w_return         int,
@w_sp_name        varchar(32),
@w_tabla          smallint,
@w_codigo         varchar(30),
@w_criterio       tinyint

select @w_sp_name = 'sp_cu01_pf'


/* LA 1A VEZ ENVIA LAS ETIQUETAS QUE APARECERAN EN LOS CAMPOS DE LA FORMA */
if @i_criterio is null begin
   select 'Clase Cartera',
          'Tipo Garantia',
          'Estado'
end

select @w_criterio = isnull(@i_criterio, 0)
select @w_codigo   = isnull(@i_codigo, '')

/* TABLA TEMPORAL PARA LLENAR LOS DATOS DE TODOS LOS DATOS DEL F5 AL CARGAR LA PANTALLA */
create table #ca_catalogo(
ca_tabla       tinyint,
ca_codigo      varchar(30),
ca_descripcion descripcion)

/* CLASE CARTERA*/
if @w_criterio <= 1 begin

   insert into #ca_catalogo
   select 1, cat.codigo, cat.valor
   from   cobis..cl_tabla tab, cobis..cl_catalogo cat
   where  tab.tabla  = 'cr_clase_cartera'
   and    tab.codigo = cat.tabla

   if @@error <> 0 return 190001
end

/* TIPO GARANTIA */
if @w_criterio <= 2 begin

   insert into #ca_catalogo
   select 2, cat.codigo, cat.valor
   from   cobis..cl_tabla tab, cobis..cl_catalogo cat
   where  tab.tabla  = 'cr_tipo_custodia'
   and    tab.codigo = cat.tabla

   if @@error <> 0 return 190001   
end

/* ESTADO DE LA GARANTIA */
if @w_criterio <= 3 begin

   insert into #ca_catalogo
   select 3, 'F', 'FUTUROS CREDITOS'
   insert into #ca_catalogo
   select 3, 'V', 'VIGENTE'
   insert into #ca_catalogo
   select 3, 'X', 'POR CANCELAR'
   insert into #ca_catalogo
   select 3, 'K', 'CASTIGADA'
   
   if @@error <> 0 return 190001
end

/* RETORNA LOS DATOS AL FRONT-END */
select ca_tabla, ca_codigo, ca_descripcion
from   #ca_catalogo
where  ca_tabla   > @w_criterio
or    (ca_tabla  = @w_criterio and ca_codigo > @w_codigo)
order by ca_tabla, ca_codigo

return 0
go



/*paraut.sp**************************************************************/
/*                                                                      */
/*      Stored procedure:       sp_parametro_auto                       */
/*      Base de Datos:          cob_conta                               */
/*                                                                      */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA' del Ecuador.                                           */
/*                                                                      */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              MODIFICACIONES                          */
/* FECHA      AUTOR             RAZON                                   */
/* 22-05-08   J.OLMEDO       VERSION BANCO DE FOMENTO                   */
/************************************************************************/

use cob_conta
go
 
if exists (select * from sysobjects where name = 'sp_parametro_auto')
   drop proc sp_parametro_auto
go
 
 
create proc sp_parametro_auto (
@i_empresa     tinyint     = 1,
@i_producto    smallint    = null,
@i_parametro   varchar(10) = null,
@i_criterio    tinyint     = null,
@i_codigo      varchar(30) = null,
@t_trn         int         = null
)
as declare  
@w_sp_name     varchar(50),
@w_texto       varchar(255),
@w_error       int,
@w_cont        int,
@w_producto    int,
@w_descripcion descripcion


/* BUSCAR SP ASOCIADO */
select  
@w_sp_name     = pa_stored
from cb_parametro
where pa_empresa     = @i_empresa
--and   pa_producto    = @i_producto  --LAZG No Existe en esta version este campo
and   pa_parametro   = @i_parametro

if @@rowcount = 0 begin
   select @w_error = 141009
   goto error
end

/* COMPLETAR EL NOMBRE DEL SP */
select 
@w_sp_name = case @i_producto
when  1 then 'cobis..'          + @w_sp_name
when  2 then 'cobis..'          + @w_sp_name
when  3 then 'cob_cuentas..'    + @w_sp_name
when  4 then 'cob_ahorros..'    + @w_sp_name
when  6 then 'cob_conta..'      + @w_sp_name
when  7 then 'cob_cartera..'    + @w_sp_name
when 10 then 'cob_remesas..'    + @w_sp_name
when 12 then 'cob_tesoreria..'  + @w_sp_name
when 14 then 'cob_pfijo..'      + @w_sp_name
when 19 then 'cob_custodia..'   + @w_sp_name
when 21 then 'cob_credito..'    + @w_sp_name
when 26 then 'cob_remesas..'    + @w_sp_name
when 42 then 'cob_sbancarios..' + @w_sp_name
end

/* INVOCAR SP ASOCIADO */
exec @w_error = @w_sp_name
@i_criterio = @i_criterio,
@i_codigo   = @i_codigo

if @w_error <> 0 goto error


return 0

error:

exec cobis..sp_cerror 
@t_debug = 'N',    
@t_from  = @w_sp_name,  
@i_num   = @w_error

go

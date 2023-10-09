/************************************************************************/
/*   Archivo:                niif_tercero.sp                            */
/*   Stored Procedure:       sp_niif_tercero                            */
/*   Producto:               Contabilidad                               */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "COBISCORP S.A".                                                   */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP S.A o su representante.         */
/************************************************************************/
/*                            PROPOSITO                                 */
/*   Genera los asientos y comprobante contables cuando se presentan    */
/*   inconsistecias en la reclasificacion de terceros de desmebolsos    */
/*   de alianzas.                                                       */
/************************************************************************/
/*                           MODIFICACION                               */
/*    FECHA             AUTOR             RAZON                         */
/*    09/03/2014        ALEJANDRA CELIS   NR462 INTERFAZ CORVUS TERCEROS*/
/*    16/03/2015        Oscar Saavedra    NR510 INTERFAZ CORVUS TERCEROS*/
/************************************************************************/
use cob_conta
go


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select 1 from sysobjects where name = 'sp_niif_tercero')
   drop proc sp_niif_tercero
go

create proc sp_niif_tercero
@i_param1  as varchar(12) = null,
@i_param2  as varchar(12) = null
as
declare
@w_error           int,
@w_mensaje         varchar(255),
@w_ced_ruc         varchar(16), 
@w_tope            int,
@w_num_reg         int,
@w_fecha_dia       datetime,
@w_fecha_dia_fin   datetime,
@w_ano_ini         smallint,
@w_ano_fin         smallint,
@w_tabla           int

select
@w_error = 0,
@w_tope  = 50000

select @w_fecha_dia = convert(datetime, @i_param1)
select @w_fecha_dia_fin = convert(datetime, @i_param2)

/*******INSERCION AUXILIAR*******/
if (@w_fecha_dia > @w_fecha_dia_fin)
begin
  print 'LA FECHA INICIAL NO PUEDE SER MAYOR QUE LA FECHA FINAL '
  return 1
end  

select @w_ano_ini = datepart(yyyy,@w_fecha_dia)
select @w_ano_fin = datepart(yyyy,@w_fecha_dia_fin)

if (datediff(mm,@w_fecha_dia, @w_fecha_dia_fin) + 1) > 3 begin
  print 'LAS FECHAS DEBEN SER DEL MISMO TRIMESTRE'
  return 1
end  

if (@w_ano_ini <> @w_ano_fin) begin
  print 'LAS FECHAS DEBEN SER DEL MISMO AÑO'
  return 1
end

select @w_tabla = isnull(codigo,0)
from   cobis..cl_tabla
where  tabla = 'ex_int_auxiliar'

if @@error <> 0 begin
   print 'ERROR AL LEER LA TABLA ex_int_auxiliar EN cobis..cl_tabla ' 
   select @w_mensaje  = 'ERROR AL LEER LA TABLA ex_int_auxiliar EN cobis..cl_tabla ' 
   goto ERRORFIN      
end

if @w_tabla = 0 begin
   print 'NO SE ENCONTRO LA TABLA ex_int_auxiliar EN cobis..cl_tabla ' 
   select @w_mensaje  = 'NO SE ENCONTRO LA TABLA ex_int_auxiliar EN cobis..cl_tabla '  
   goto ERRORFIN      
end

truncate table cob_externos..ex_int_auxiliar

while (@w_fecha_dia <= @w_fecha_dia_fin) begin
   print 'FECHA DE PROCESO ES  ' + convert(varchar, @w_fecha_dia)
   select @w_ced_ruc  = '0'
   set rowcount @w_tope  
   
   while (1= 1) begin   
      insert into cob_externos..ex_int_auxiliar(
	  ia_TipoDocumento,   ia_NumeroDocumento,            ia_Sigla,       ia_DescripcionActividadEcon,
      ia_RazonSocial,     ia_CodigoActividadEconomica,   ia_Direccion,   ia_Telefono,    
      ia_CodigoEmpresa,   ia_Codigo_Ciudad,              ia_Codigo_Depto)
      select
      en_tipo_ced,
      substring(en_ced_ruc,1,12),
      isnull(en_nomlar,'SIN_ESPECIFICAR'),
      isnull((select  isnull(valor,' ') from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cl_actividad' and c.codigo = en_actividad), ' ')  act,
      isnull(en_nomlar, 'SIN_ESPECIFICAR'), 
      isnull(en_actividad,' '),
      isnull(di_descripcion,'SIN_ESPECIFICAR'),
      (case when  isnull(ltrim(rtrim(te_prefijo)),'') = '' and  (isnull(ltrim(rtrim(te_valor)),'') ='') then 'SIN_ESPECIFICAR' 
            else isnull(ltrim(rtrim(te_prefijo)),' ') + '-'  + isnull(ltrim(rtrim(te_valor)),' ')
       end),
      '1' cod,
      (case when di_ciudad is null then  'SIN_ESPECIFICAR' else replicate ('0',(5 - len(di_ciudad))) + convert(varchar, di_ciudad) end)  ciudad, 
      (case when di_ciudad is null then  'SIN_ESPECIFICAR' else substring((replicate ('0',(5 - len(di_ciudad))) + convert(varchar, di_ciudad)),1,2)  end) dep
      from   cobis..cl_ente left join  cobis..cl_direccion d1
      on     en_ente         = d1.di_ente 
      and    d1.di_principal = 'S'
      and    di_direccion    = (select MIN(di_direccion) from cobis..cl_direccion d2 where d2.di_ente = en_ente and d2.di_principal = 'S')
      left outer join cobis..cl_telefono
      on     d1.di_ente      = te_ente
      and    d1.di_direccion = te_direccion
      and    te_secuencial   = (select MIN(te_secuencial) from cobis..cl_telefono where d1.di_ente = te_ente and d1.di_direccion = te_direccion)
      where  en_ced_ruc      > @w_ced_ruc
      and    en_fecha_crea  >= @w_fecha_dia
      and    en_fecha_crea   < dateadd(dd,1,@w_fecha_dia)
      union      
      select
      en_tipo_ced,
      substring(en_ced_ruc,1,12),
      isnull(en_nomlar,'SIN_ESPECIFICAR'),
      isnull((select  isnull(valor,' ') from cobis..cl_catalogo c, cobis..cl_tabla t where c.tabla = t.codigo and t.tabla = 'cl_actividad' and c.codigo = en_actividad), ' ' )  act,
      isnull(en_nomlar, 'SIN_ESPECIFICAR'), 
      isnull(en_actividad,' '),
      isnull(di_descripcion,'SIN_ESPECIFICAR'),
      (case when  isnull(ltrim(rtrim(te_prefijo)),'') = '' and  (isnull(ltrim(rtrim(te_valor)),'') ='') then 'SIN_ESPECIFICAR' 
            else isnull(ltrim(rtrim(te_prefijo)),' ') + '-'  + isnull(ltrim(rtrim(te_valor)),' ')
       end),
      '1' cod,
      (case when di_ciudad is null then  'SIN_ESPECIFICAR' else replicate ('0',(5 - len(di_ciudad))) + convert(varchar, di_ciudad) end)  ciudad, 
      (case when di_ciudad is null then  'SIN_ESPECIFICAR' else substring((replicate ('0',(5 - len(di_ciudad))) + convert(varchar, di_ciudad)),1,2)  end) dep
      from   cobis..cl_ente left join cobis..cl_direccion d1
      on     en_ente         = d1.di_ente 
      and    d1.di_principal = 'S'
      and    di_direccion    = (select MIN(di_direccion) from cobis..cl_direccion d2 where d2.di_ente = en_ente and d2.di_principal = 'S')
      left outer join cobis..cl_telefono
      on     d1.di_ente      = te_ente
      and    d1.di_direccion = te_direccion
      and    te_secuencial   = (select MIN(te_secuencial) from cobis..cl_telefono where d1.di_ente = te_ente and d1.di_direccion = te_direccion)
      join cobis..cl_actualiza
	  on     ac_ente         = en_ente
      where  en_ced_ruc      > @w_ced_ruc
      and    ac_fecha       >= @w_fecha_dia
      and    ac_fecha        < dateadd(dd,1,@w_fecha_dia)
      and    ac_transaccion  = 'U'
      and    ac_campo in (select valor from cobis..cl_catalogo where tabla = @w_tabla and estado = 'V')
      order by substring(en_ced_ruc,1,12)
    
      select
	  @w_num_reg = @@ROWCOUNT,
      @w_error = @@error  
    
      if @w_error <> 0 begin
	     select @w_error = @@error
         print 'ERROR AL INSERTAR AUXILIAR '  + 'Bloque de Ente desde : ' + convert(varchar(16), @w_ced_ruc)
         select @w_mensaje  = 'ERROR AL INSERTAR AUXILIAR ' + 'Fec. Proceso ' + convert(varchar(10),@w_fecha_dia,112) + ' Bloque de Ente desde : ' + convert(varchar(16), @w_ced_ruc)
         goto ERRORFIN
      end
	  else begin
	     print 'INSERCION EXITOSA DE AUXILIAR EN COB_EXTERNOS ' + 'Bloque de Ente desde : ' + convert(varchar(16), @w_ced_ruc)
         insert into cob_externos..ex_control_corvus
         select getdate(),'cob_externos..ex_int_auxiliar' ,'sp_niif_tercero', 'P','N','Fec. Proceso ' + convert(varchar(10),@w_fecha_dia,112) + ' Bloque de Ente desde : ' + convert(varchar(16), @w_ced_ruc)
      end

      update cob_externos..ex_int_auxiliar
      set    ia_Codigo_Ciudad = replicate ('0',(5 - len(of_ciudad))) + convert(varchar, of_ciudad),
             ia_Codigo_Depto  = substring((replicate ('0',(5 - len(of_ciudad))) + convert(varchar, of_ciudad)),1,2)
      from   cobis..cl_ente, cobis..cl_oficina    
      where  ia_Codigo_Ciudad = 'SIN_ESPECIFICAR'
      and    en_oficina       = of_oficina
      and    en_tipo_ced      = ia_TipoDocumento
      and    substring(en_ced_ruc,1,12)  = ia_NumeroDocumento
	  
	  if @w_num_reg = 0
         break
		 
      select @w_ced_ruc = MAX (en_ced_ruc)  
      from   cobis..cl_ente, cob_externos..ex_int_auxiliar
      where  en_tipo_ced = ia_TipoDocumento 	
      and    substring(en_ced_ruc,1,12) = ia_NumeroDocumento
   end --while
   select @w_fecha_dia  = dateadd(dd,1,@w_fecha_dia)
end -- while de rangos de fehas

set rowcount 0
return 0

ERRORFIN:
insert into cob_externos..ex_control_corvus
select getdate(),'cob_externos..ex_int_auxiliar' ,'sp_niif_tercero', 'E','N',@w_mensaje
go


/*
exec sp_niif_tercero
@i_param1 = '05/01/2014',
@i_param2 = '05/30/2014'
select * from cob_externos..ex_control_corvus
select * from cob_externos..ex_int_auxiliar

*/
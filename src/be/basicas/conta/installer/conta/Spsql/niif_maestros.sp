/************************************************************************/
/*   Archivo:                niif_maestros.sp                           */
/*   Stored Procedure:       sp_niif_maestros                           */
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
/*    05/05/2014        ALEJANDRA CELIS   NR429 INTERFAZ CORVUS MAESTROS*/
/************************************************************************/
use cob_conta
go


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

if exists (select 1 from sysobjects where name = 'sp_niif_maestros')
   drop proc sp_niif_maestros
go

create proc sp_niif_maestros
as
declare
@w_error        int,
@w_mensaje      varchar(255),
@w_fecha_crea   datetime,
@w_ente         int,
@w_tope         int,
@w_num_reg      int

select @w_error = 0
select @w_fecha_crea = GETDATE() --convert(datetime, @i_param1)
select @w_tope = 50000

/*****INSERCION CENTRO DE COSTOS ****/
truncate table cob_externos..ex_int_centrocosto
insert into cob_externos..ex_int_centrocosto
   (ic_CodigoEmpresa,   ic_CodigoCentroCosto, ic_Observacion,	ic_FechaVigencia)
    select 
    of_empresa,         of_oficina,           of_descripcion,   '2100/01/01'  
   from  cob_conta..cb_oficina
   where of_movimiento = 'S'
   and   of_oficina not in (select oficina_padre 
                         from cob_conta..ts_oficina
                         where fecha           >= '06/10/2014'
                         and   tipo_transaccion = 6151)
     
if @@error <> 0   begin
   print 'ERROR AL INSERTAR CENTRO DE COSTO ' 
   select @w_mensaje  = 'ERROR AL INSERTAR CENTRO DE COSTO '
   goto ERRORFIN
end
else
begin
   print 'INSERCION EXITOSA DE CENTRO DE COSTO EN COB_EXTERNOS ' 
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_centrocosto' ,'sp_niif_maestros', 'P','N',null
end   

/*****INSERCION BANCO*****/
truncate table cob_externos..ex_int_banco 
insert into cob_externos..ex_int_banco
    (ib_CodigoBanco,   ib_Nombre)
    select 
     pa_parametro,     pa_smallint
    from  cobis..cl_parametro
    where pa_nemonico = 'CORVUS'
   
if @@error <> 0   begin
   print 'ERROR AL INSERTAR BANCO ' 
   select @w_mensaje  = 'ERROR AL INSERTAR BANCO '
   goto ERRORFIN

end
else
begin 
   print 'INSERCION EXITOSA DE BANCO EN COB_EXTERNOS ' 
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_banco' ,'sp_niif_maestros', 'P','N',null
end



/******INSERCION MONEDA*****/
truncate table cob_externos..ex_int_moneda
insert into cob_externos..ex_int_moneda
    (im_Simbolo,    im_Nombre,  	im_Descripcion,	im_NumeroDecimales)
    select 
     'COP',	'Pesos Colombianos',	'Para uso local',	2

if @@error <> 0   begin
   print 'ERROR AL INSERTAR MONEDA ' 
   select @w_mensaje  = 'ERROR AL INSERTAR MONEDA ' 
   goto ERRORFIN

end
else
begin
   print 'INSERCION EXITOSA DE MONEDA EN COB_EXTERNOS ' 
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_moneda' ,'sp_niif_maestros', 'P','N',null
end   

/*******INSERCION AUXILIAR*******/
truncate table cob_externos..ex_int_auxiliar
select @w_ente  = 0
set rowcount  @w_tope  
while (1= 1)
begin

  insert into cob_externos..ex_int_auxiliar
             (ia_TipoDocumento, 	ia_NumeroDocumento,  ia_Sigla,	 
              ia_DescripcionActividadEcon,
              ia_RazonSocial,     ia_CodigoActividadEconomica,ia_Direccion,
              ia_Telefono,    
              ia_CodigoEmpresa,	ia_Codigo_Ciudad,   ia_Codigo_Depto)
  select    
              en_tipo_ced,         substring(en_ced_ruc,1,12),            isnull(en_nomlar,'SIN_ESPECIFICAR'),
              isnull((select  isnull(valor,' ') 
                      from    cobis..cl_catalogo c, cobis..cl_tabla t
                      where   c.tabla = t.codigo
                      and     t.tabla = 'cl_actividad'
                      and     c.codigo = en_actividad), ' ' )  act      ,
             isnull(en_nomlar, 'SIN_ESPECIFICAR'),          isnull(en_actividad,' '),           isnull(di_descripcion,'SIN_ESPECIFICAR'), 
             (case when  isnull(ltrim(rtrim(te_prefijo)),'') = '' and  (isnull(ltrim(rtrim(te_valor)),'') ='') then 'SIN ESPECIFICAR' 
                   else isnull(ltrim(rtrim(te_prefijo)),' ') + '-'  + isnull(ltrim(rtrim(te_valor)),' ') END),
             '1' cod,         (case when di_ciudad is null then  'SIN_ESPECIFICAR' else replicate ('0',(5 - len(di_ciudad))) + convert(varchar, di_ciudad) end)  ciudad, 
             (case when di_ciudad is null then  'SIN_ESPECIFICAR' else substring((replicate ('0',(5 - len(di_ciudad))) + convert(varchar, di_ciudad)),1,2)  end) dep
   from   cobis..cl_ente left join  cobis..cl_direccion d1
   on     en_ente  = d1.di_ente 
   and    d1.di_principal = 'S'
   and di_direccion = ( select MIN(di_direccion) 
                        from cobis..cl_direccion d2            
                        where d2.di_ente = en_ente
                        and   d2.di_principal = 'S'
                      )
          left outer join cobis..cl_telefono
          on     d1.di_ente = te_ente
          and    d1.di_direccion = te_direccion
          and te_secuencial = ( select MIN(te_secuencial) 
                                from cobis..cl_telefono            
                                where d1.di_ente = te_ente
                                and   d1.di_direccion = te_direccion)
   where  en_ente > @w_ente
          and    en_fecha_crea <= '12/31/2013'
   order by en_ente
    
   select @w_num_reg = @@ROWCOUNT,
          @w_error = @@error  
    
  if @w_error <> 0   begin
        select @w_error = @@error
        print 'ERROR AL INSERTAR AUXILIAR '  + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
        select @w_mensaje  = 'ERROR AL INSERTAR AUXILIAR ' + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
        goto ERRORFIN
  end
  else
  begin
        print 'INSERCION EXITOSA DE AUXILIAR EN COB_EXTERNOS ' + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
        insert into cob_externos..ex_control_corvus
        select getdate(),'cob_externos..ex_int_auxiliar' ,'sp_niif_maestros', 'P','N','Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
  end    

  
  if @w_num_reg = 0
     break
     
    
  select @w_ente = MAX (en_ente)  
  from   cobis..cl_ente, cob_externos..ex_int_auxiliar
  where  en_tipo_ced  = ia_TipoDocumento 	
  and    substring(en_ced_ruc,1,12)    = ia_NumeroDocumento
end --while


set rowcount 0
/*** ACTUALIZACION DE CODIGOS DE CIUDADES NO DANE ***/ 
update cob_externos..ex_int_auxiliar
set ia_Codigo_Ciudad = SUBSTRING(ia_Codigo_Ciudad,1,2) + '001'
where ia_Codigo_Ciudad in  ( select c.codigo from cobis..cl_catalogo c 
                             where c.estado = 'V' 
                             and c.tabla = (select codigo from cobis..cl_tabla t 
                                            where t.tabla = 'cl_nodane')) 
if @@error <> 0   begin
   select @w_error = @@error
   print 'ERROR AL ACTUALIZAR CODIGOS NO DANE '  + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
   select @w_mensaje  = 'ERROR AL ACTUALIZAR CODIGOS NO DANE ' + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
   goto ERRORFIN
end
else
begin
   print 'ACTUALIZACION EXITOSA DE CODIGOS NO DANE'
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_auxiliar' ,'sp_niif_maestros', 'P','N','ACTUALIZACION EXITOSA DE CODIGOS NO DANE'
   
end



/*** ACTUALIZACION DE CODIGOS DE CIUDADES  CON CODIGO 00000 ***/ 
update cob_externos..ex_int_auxiliar
set     ia_Codigo_Ciudad = (select replicate ('0',(5 - len(of_ciudad))) + convert(varchar, of_ciudad)
                         from  cobis..cl_oficina
                         where of_oficina = (select en_oficina 
                                             from  cobis..cl_ente
                                             where en_tipo_ced = ia_TipoDocumento
                                             and   substring(en_ced_ruc,1,12)  = ia_NumeroDocumento )),
  ia_Codigo_Depto = substring((select replicate ('0',(5 - len(of_ciudad))) + convert(varchar, of_ciudad)
                         from  cobis..cl_oficina
                         where of_oficina = (select en_oficina 
                                             from  cobis..cl_ente
                                             where en_tipo_ced = ia_TipoDocumento
                                             and   substring(en_ced_ruc,1,12)  = ia_NumeroDocumento )),1,2)
                                             
where ia_Codigo_Ciudad = '00000'

if @@error <> 0   begin
   select @w_error = @@error
   print 'ERROR AL ACTUALIZAR CODIGOS DE CIUDAD EN CEROS '  + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
   select @w_mensaje  = 'ERROR AL ACTUALIZAR CODIGOS DE CIUDAD EN CEROS ' + 'Bloque de Ente desde : ' + convert(varchar(10), @w_ente)
   goto ERRORFIN
end
else
begin
   print 'ACTUALIZACION EXITOSA DE CIUDAD EN CEROS'
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_auxiliar' ,'sp_niif_maestros', 'P','N','ACTUALIZACION EXITOSA DE CIUDAD EN CEROS'
   
end   

   
/***********INSERCION CUENTA HOLDING***************/

truncate table cob_externos..ex_int_cuentaholdingERP 
insert into cob_externos..ex_int_cuentaholdingERP(
	ic_CodigoCuenta,	ic_Descripcion,  	ic_Naturaleza,
	ic_FechaVigencia,	ic_UsaCentro,   	ic_UsaProyecto,
	ic_UsaCuentaTercero,ic_CodigoHolding)
select  distinct  
    cu_cuenta,          cu_nombre,
    (case when substring(cu_cuenta,1,1) = 1 then 0
    when substring(cu_cuenta,1,1) = 2 then 1 
    when substring(cu_cuenta,1,1) = 3 then 2 
    when (cu_cuenta like '4%') and (substring(cu_cuenta,1,2) not in (42,43)) then 3
    when (cu_cuenta like '4%') and (substring(cu_cuenta,1,2) in (42,43))  then 5 
    when (cu_cuenta like '5%') and (substring(cu_cuenta,1,2) not in ('52','53','54','59')) then 4
    when (cu_cuenta like '5%') and (substring(cu_cuenta,1,2) in ('52','53','54','59'))  then 6 
    when (cu_cuenta like '6%' )  then 7 
    when (cu_cuenta like '8%' )  then 8 
    else null end),
    '2100/12/31',        1,                  0,
     1,                  1
from cob_conta..cb_cuenta
where cu_cuenta not in   (select cuenta from cob_conta..ts_cuenta
                          where  tipo_transaccion = 6011
                          and    fecha >= '01/01/2014'
                        )
and   substring(cu_cuenta,1,1) in (1,2,3,4,5)

if @@error <> 0   begin
   select @w_error = @@error
   print 'ERROR AL INSERTAR CUENTAS HOLDING '
   select @w_mensaje  = 'ERROR AL INSERTAR CUENTAS HOLDING ' 
   goto ERRORFIN

end
else
begin
   print 'INSERCION EXITOSA DE CUENTAS HOLDING EN COB_EXTERNOS'
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_cuentaholdingERP' ,'sp_niif_maestros', 'P','N',null
   
end   

/***********INSERCION CUENTA EMPRESA***************/
	
truncate table cob_externos..ex_int_cuentaempresaERP
insert into cob_externos..ex_int_cuentaempresaERP
	       (ic_CodigoCuenta,    ic_CodigoEmpresa)
select     cu_cuenta,              1
from  cob_conta..cb_cuenta
where cu_cuenta not in   (select cuenta from cob_conta..ts_cuenta
                          where  tipo_transaccion = 6011
                          and    fecha >= '01/01/2014'
                        )
and   substring(cu_cuenta,1,1) in (1,2,3,4,5)
	   
if @@error <> 0   begin
   print 'ERROR AL INSERTAR CUENTA EMPRESA ' 
   select @w_mensaje  = 'ERROR AL INSERTAR  CUENTA EMPRESA' 
   goto ERRORFIN

end
else
begin
   print 'INSERCION EXITOSA DE CUENTA EMPRESA EN COB_EXTERNOS'
   insert into cob_externos..ex_control_corvus
   select getdate(),'cob_externos..ex_int_cuentaempresaERP' ,'sp_niif_maestros', 'P','N',null
end   




return 0

ERRORFIN:
  insert into cob_externos..ex_control_corvus
        select getdate(),'cob_externos..ex_int_auxiliar' ,'sp_niif_maestros', 'E','N',@w_mensaje
go

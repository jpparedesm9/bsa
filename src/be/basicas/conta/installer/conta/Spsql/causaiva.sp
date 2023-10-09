/************************************************************************/
/*	Archivo: 		causaiva.sp                             */
/*	Stored procedure: 	sp_causacion_iva                        */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTA                                   */
/*	Disenado por:           Ocrios        .                         */
/*	Fecha de escritura:     11/mayo/2005                            */
/************************************************************************/
/*				IMPORTANTE		                */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de          */
/*	"MACOSA".                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus	        */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.	        */
/************************************************************************/
/*				PROPOSITO			        */
/*  Muestreo del IVA - Anexo                                            */
/************************************************************************/
/*				MODIFICACIONES	                        */
/*	FECHA		AUTOR		RAZON 	                        */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_causacion_iva')
	drop proc sp_causacion_iva
go

create proc sp_causacion_iva (	
        @s_ssn                  int             = NULL,
        @s_user                 login           = NULL,
        @s_term                 varchar(30)     = NULL,
        @s_date                 datetime        = NULL,
        @s_sesn                 int             = NULL,
        @s_ssn_branch           int             = null, 
        @s_srv                  varchar(30)     = NULL,
        @s_lsrv                 varchar(30)     = NULL,
        @s_ofi                  smallint        = NULL,
        @s_rol                  smallint        = NULL,
        @t_debug                char(1)         = 'N',
        @t_file                 varchar(10)     = NULL,
        @t_from                 varchar(32)     = NULL,
        @t_trn                  smallint        = NULL,
        @i_opcion               int, 
        @i_tipo                 char(2)         = NULL, 
        @i_frontend             char(1), 
        @i_empresa              int,
        @i_par_producto         char(4)         = NULL,
        @i_fecha_ini            datetime        = NULL,
        @i_fecha_fin            datetime,
        @i_proceso              int
)
as

/* 
print 'Opcion %1!', @i_opcion
print 'Tipo %1!',       @i_tipo
print 'Frontend  %1!',   @i_frontend
print 'Empresa %1!',     @i_empresa
print 'Par_producto %1!',@i_par_producto
print 'Fecha Fin  %1!',  @i_fecha_fin
print 'Proceso  %1!',    @i_proceso

*/



/*DECLARACION DE VARIABLES TEMPORALES DE TRABAJO*/
declare @w_cuenta            cuenta_contable,
        @w_sp_name           varchar(32),                       
        @w_oficina           smallint,             
        @w_empresa           tinyint,
        @w_batch             int,
        @w_producto          tinyint,
        @w_fecha             datetime,
        @w_procesadas        int, 
        @w_dsc_programa      varchar(20),
        @w_cuenta_iva    varchar(4),
        @w_cuenta_ing    varchar(4)
        

begin

/*ASIGNACION DE VARIABLES*/

select @w_sp_name   = 'sp_causacion_iva'    


if (@i_frontend = 'S'  and @t_trn <> 6199)
begin
      /* 'Tipo de transaccion no corresponde' */
     exec cobis..sp_cerror
   	   @t_debug = @t_debug,
 	   @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_num   = 601077
     return 1
end
 
if @i_opcion != 10 and @i_opcion != 11
  return 1 

if @i_opcion = 10    
  begin
    select @w_cuenta_iva = 'IVA1'
    select @w_cuenta_ing = 'ING1'
  end
              
if @i_opcion = 11    
  begin
    select @w_cuenta_iva = 'IVA2'
    select @w_cuenta_ing = 'ING2'
  end

 
if @i_par_producto is not null
begin
    select 'cb_producto' =  convert(int,cp_texto)
            into #tmp_producto
    from  cob_conta..cb_cuenta_proceso
    where cp_empresa     = @i_empresa
    and   cp_proceso     = @i_proceso
    and   cp_condicion   = @i_par_producto
end



if @i_frontend = 'N'    -- se hace extraccion de datos
begin
       select ltrim(rtrim(cp_cuenta)) cp_cuenta, cp_condicion 
       into #tmp_cuenta
       from   cob_conta..cb_cuenta_proceso
       where  cp_empresa     = @i_empresa
       and    cp_proceso     = @i_proceso
       and    cp_condicion   in ( @w_cuenta_ing, @w_cuenta_iva)

   if @i_par_producto is not null and @i_tipo = 'CM'    -- se debe hacer la extracción de cob_conta_tercero.
     Begin
 
          --Limpiar las tablas temporales de sumatoria de movimiento
          delete cob_conta..cb_tmp_ivamovsum
          where iv_opcion   = @i_opcion
          and   iv_fecha_fin   = @i_fecha_fin
                     
          insert into  cb_tmp_ivamovsum (iv_proceso, iv_opcion, iv_empresa, iv_producto, iv_debito, iv_credito,
                        iv_cuenta, iv_fecha_ini, iv_fecha_fin, iv_condicion, iv_fecha_proc)
           select  @i_proceso, @i_opcion, iv_empresa, iv_producto, 
           sum(iv_debito),
           sum(iv_credito),
           iv_cuenta, 
           @i_fecha_ini,
           @i_fecha_fin,
           cp_condicion,
           getdate()
           from  cb_tmp_ivamov, #tmp_cuenta, #tmp_producto
           where iv_empresa = @i_empresa
           and   iv_producto = cb_producto
           and   iv_cuenta like cp_cuenta + '%'
           --and   iv_fecha_ini = @i_fecha_ini
           and   iv_fecha_fin = @i_fecha_fin
           group by  iv_empresa, iv_producto, iv_cuenta, cp_condicion


      end  -- producto is not null
   end  -- front end = 'N'
   
if @i_frontend = 'S'    
begin

   create table #tmp_iva
      (
       iv_producto  tinyint,
       iv_dsc_producto varchar(60)    null,
       iv_cuenta_ingr     varchar(16) null,
       iv_neto_ingr      money        null,
       iv_cuenta_iva     varchar(16)  null,
       iv_neto_iva       money        null
      )

   if @i_opcion  in (10, 11)
   begin
   
  -- Se calcula la sumatoria  de las cuentas de ingreso sobre la tabla  cb_tmp_ivamovsum  y se inserta en la tabla #tmp_iva

     insert into #tmp_iva
     select iv_producto,  null, iv_cuenta, 'iv_neto_ing'= sum(iv_credito) - sum(iv_debito), null, null
     from cb_tmp_ivamovsum
     where iv_opcion = @i_opcion 
     and iv_empresa = @i_empresa
     and iv_fecha_fin = @i_fecha_fin
     and iv_condicion = @w_cuenta_ing
     group by iv_producto, iv_cuenta

  -- Se calcula la sumatoria  de las cuentas de iva sobre la tabla  cb_tmp_ivamovsum  y se inserta en la tabla #tmp_iva

     insert into #tmp_iva
     select iv_producto,  null, null, null, iv_cuenta, 'iv_neto_iva' = sum(iv_credito) - sum(iv_debito)
     from cb_tmp_ivamovsum
     where iv_opcion = @i_opcion 
     and iv_empresa = @i_empresa
     and iv_fecha_fin = @i_fecha_fin
     and iv_condicion = @w_cuenta_iva
     group by iv_producto, iv_cuenta


     update #tmp_iva
     set  iv_dsc_producto =  (select  pd_descripcion from cobis..cl_producto where pd_producto = a.iv_producto)
     from #tmp_iva a


-- Se retorna  la consulta sobre la tabla #tmp_iva, la cual es retornada a la hoja excel:


      select iv_producto, iv_dsc_producto, sum(iv_neto_ingr) neto_ingr, sum(iv_neto_iva)  neto_iva
      from  #tmp_iva
      group by iv_producto, iv_dsc_producto
      
   end

end -- if @i_frontend = 'S'

end
go


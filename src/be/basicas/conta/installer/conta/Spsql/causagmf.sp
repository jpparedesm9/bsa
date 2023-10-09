/************************************************************************/
/*	Archivo: 		causagmf.sp                             */
/*	Stored procedure: 	sp_causacion_gmf                        */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               CONTA                                   */
/*	Disenado por:           Ocrios        .                         */
/*	Fecha de escritura:     27/mayo/2005                            */
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
/*  Muestreo de Causacion del  GMF sobre debitos contables              */
/************************************************************************/
/*				MODIFICACIONES	                        */
/*	FECHA		AUTOR		RAZON 	                        */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_causacion_gmf')
	drop proc sp_causacion_gmf
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_causacion_gmf (	
        @s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
	@s_ofi		smallint = null,
	@t_rty		char(1) = null,
	@t_trn		int = null,
	@t_debug	char(1)     = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
        @i_opcion       int             = NULL, 
        @i_tipo         char(2)         = NULL, 
        @i_frontend     char(1)         = NULL, 
        @i_empresa      tinyint         = NULL,
        @i_par_cuenta   char(4)         = NULL,
        @i_par_producto char(4)         = NULL,
        @i_fecha_ini    datetime        = NULL,
        @i_fecha_fin    datetime        = NULL,
        @i_proceso      int             = NULL 
)
as

/*DECLARACION DE VARIABLES TEMPORALES DE TRABAJO*/
declare @w_cuenta            cuenta_contable,
        @w_sp_name           varchar(32),                       
        @w_oficina           smallint,             
        @w_empresa           tinyint,
        @w_batch             int,
        @w_producto          tinyint,
        @w_fecha             datetime,
        @w_procesadas        int, 
        @w_dsc_programa      varchar(20)
        
        

begin

/*ASIGNACION DE VARIABLES*/

select @w_sp_name         = 'sp_causacion_gmf'     

/* 
print 'Iniciando proceso'

print '@t_trn  %1!', @t_trn
print 'Opcion %1! ' , @i_opcion
print 'Tipo %1! ' , @i_tipo
print 'Frontend %1!' , @i_frontend
print 'Empresa   %1!', @i_empresa 
print 'Par cuenta %1!', @i_par_cuenta
print 'Par producto %1!', @i_par_producto
print 'Fecha ini %1!', @i_fecha_ini
print 'Fecha fin  %1!', @i_fecha_fin
print 'Proceso  %1!', @i_proceso


*/ 


if @i_frontend = 'S' 
begin
  if (@t_trn <> 6185 and  
      @t_trn <> 6186 and 
      @t_trn <> 6187 and 
      @t_trn <> 6198)
     
      begin
      /* 'Tipo de transaccion no corresponde' */
           exec cobis..sp_cerror
   	   @t_debug = @t_debug,
 	   @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_num   = 601077
        return 1
     end
end


if @i_frontend = 'N'    -- se hace extraccion de datos
begin

if  @i_par_cuenta is NULL or
    @i_par_producto is NULL or
    @i_tipo   is NULL
    begin

    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 601001
        return 1 
    end

      select ltrim(rtrim(cp_cuenta)) cp_cuenta 
             into #tmp_cuenta
      from   cob_conta..cb_cuenta_proceso
      where  cp_empresa     = @i_empresa
      and    cp_proceso     = @i_proceso
      and    cp_condicion   = @i_par_cuenta
  
  
    select 'cb_producto' =  convert(int,cp_texto)
            into #tmp_producto
    from  cob_conta..cb_cuenta_proceso
    where cp_empresa     = @i_empresa
    and   cp_proceso     = @i_proceso
    and   cp_condicion   = @i_par_producto
  

    if @i_tipo = 'CM' and @i_par_cuenta  is not null   -- se hace extracción de movimimientos contables
     Begin
               --Limpiar las tablas temporales de movimientos
               delete cob_conta..cb_tmp_gmfmov
               where  gm_proceso = @i_proceso
               and    gm_opcion  =   @i_opcion

                --Limpiar las tablas temporales de sumatoria de movimiento
                -- print 'Borrando tabla  cb_tmp_gmfmovsum %1!, %2!', @i_fecha_ini, @i_fecha_fin
                delete cob_conta..cb_tmp_gmfmovsum
                where gm_proceso   = @i_proceso
                and   gm_opcion    = @i_opcion
                and   gm_fecha_ini = @i_fecha_ini
                and   gm_fecha_fin = @i_fecha_fin

 
                select @w_fecha = @i_fecha_ini
                while @w_fecha  <= @i_fecha_fin
                    begin -- para recorrido de fecha ini hasta fecha fin
                    
                        insert into cb_tmp_gmfmov (gm_proceso, gm_opcion, gm_empresa, gm_producto,gm_debito,
                               gm_credito, gm_cuenta, gm_fecha_tran, gm_comprobante, gm_asiento, gm_perfil, 
                               gm_tran_modulo) 
                        select  @i_proceso, 
                                @i_opcion, 
                                sa_empresa,
                                sa_producto, 
                                sa_debito,
                                sa_credito,
                                sa_cuenta, 
                                sa_fecha_tran,
                                sa_comprobante,
                                sa_asiento,
                                sc_perfil,
                                sc_tran_modulo 
                        from cob_conta_tercero..ct_sasiento, 
                            #tmp_cuenta, 
                            #tmp_producto,
                            cob_conta_tercero..ct_scomprobante 
                        where sc_fecha_tran    = @w_fecha
                        and  sc_producto      = cb_producto
                        and  sc_comprobante   > 0
                        and  sc_empresa       = @i_empresa
                        and  sc_estado        = 'P'
                        and  sa_empresa       = sc_empresa
                        and  sa_producto      = sc_producto
                        and  sa_fecha_tran    = sc_fecha_tran
                        and  sa_comprobante   = sc_comprobante
                        and  sa_asiento > 0
                        and  sa_cuenta like  cp_cuenta + '%'
    
                        select @w_fecha = dateadd(dd,1,@w_fecha) 
                    
                     end -- para recorrido de fecha ini hasta fecha fin

                if @i_proceso != 6021 -- != anexo 4
                begin
                   insert into cb_tmp_gmfmovsum (gm_proceso, gm_opcion, gm_empresa, gm_producto, gm_debito,
                               gm_credito, gm_cuenta, gm_fecha_ini, gm_fecha_fin, gm_fecha_proc)
                   select  gm_proceso, gm_opcion, gm_empresa, gm_producto, 
                   sum(gm_debito),
                   sum(gm_credito),
                   gm_cuenta, 
                   @i_fecha_ini,
                   @i_fecha_fin,
                   getdate()
                   from  cb_tmp_gmfmov
                   where gm_opcion = @i_opcion
                   and   gm_fecha_tran >= @i_fecha_ini
                   and   gm_fecha_tran <= @i_fecha_fin
                   group by gm_proceso, gm_opcion, gm_empresa,  gm_producto, gm_cuenta
               end
               else
               begin
               
                -- print 'Pasando por perfiles '
               
                -- Busca solamente  los perfiles y transacciones asociados a este proceso */
                -- proceso  6021  extrae perfiles y transacciones usados solamente para cheques devueltos
                -- según el anexo 4
                
                    select 'cb_perfil' =  ltrim(rtrim(cp_texto))
                    into #tmp_perfil
                    from  cob_conta..cb_cuenta_proceso
                    where cp_empresa     = @i_empresa
                    and   cp_proceso     = @i_proceso
                    and   cp_condicion   = 'PERF'
                    
                    select 'cb_transaccion' =  ltrim(rtrim(cp_texto))
                    into #tmp_transaccion
                    from  cob_conta..cb_cuenta_proceso
                    where cp_empresa     = @i_empresa
                    and   cp_proceso     = @i_proceso
                    and   cp_condicion   = 'TRAN'


                   if @i_par_cuenta = 'BGMF'  -- cuentas base
                   begin
                   
                   -- solo para creditos  tiene en cuenta el perfil

                   insert into cb_tmp_gmfmovsum (gm_proceso, gm_opcion, gm_empresa, gm_producto, gm_debito,
                               gm_credito, gm_cuenta, gm_fecha_ini, gm_fecha_fin, gm_fecha_proc)
                   select  gm_proceso, gm_opcion, gm_empresa, gm_producto, 
                   sum(gm_debito),
                   0,
                   gm_cuenta, 
                   @i_fecha_ini,
                   @i_fecha_fin,
                   getdate()
                   from  cb_tmp_gmfmov
                   where gm_opcion = @i_opcion
                   and   gm_fecha_tran >= @i_fecha_ini
                   and   gm_fecha_tran <= @i_fecha_fin
                   group by gm_proceso, gm_opcion, gm_empresa,  gm_producto, gm_cuenta


                   insert into  cb_tmp_gmfmovsum (gm_proceso, gm_opcion, gm_empresa, gm_producto, gm_debito,
                                gm_credito, gm_cuenta, gm_fecha_ini, gm_fecha_fin, gm_fecha_proc)
                   select  gm_proceso, gm_opcion, gm_empresa, gm_producto, 
                   0,
                   sum(gm_credito),
                   gm_cuenta, 
                   @i_fecha_ini,
                   @i_fecha_fin,
                   getdate()
                   from  cb_tmp_gmfmov
                   where gm_opcion = @i_opcion
                   and   gm_fecha_tran >= @i_fecha_ini
                   and   gm_fecha_tran <= @i_fecha_fin
                   and   gm_perfil in  (select cb_perfil from #tmp_perfil)
                   and   gm_tran_modulo in (select cb_transaccion from #tmp_transaccion)
                   group by gm_proceso, gm_opcion, gm_empresa,  gm_producto, gm_cuenta
                       
                       
                   end
                   
                   if @i_par_cuenta = 'CGMF'
                   begin
            
                   -- solo para debitos tiene en cuenta los perfiles
                   
                   insert into  cb_tmp_gmfmovsum (gm_proceso, gm_opcion, gm_empresa, gm_producto, gm_debito,
                                gm_credito, gm_cuenta, gm_fecha_ini, gm_fecha_fin, gm_fecha_proc)
                   select  gm_proceso, gm_opcion, gm_empresa, gm_producto, 
                   sum(gm_debito),
                   0,
                   gm_cuenta, 
                   @i_fecha_ini,
                   @i_fecha_fin,
                   getdate()
                   from  cb_tmp_gmfmov
                   where gm_opcion = @i_opcion
                   and   gm_fecha_tran >= @i_fecha_ini
                   and   gm_fecha_tran <= @i_fecha_fin
                   and   gm_perfil in  (select cb_perfil from #tmp_perfil)
                   and   gm_tran_modulo in (select cb_transaccion from #tmp_transaccion)
                   group by gm_proceso, gm_opcion, gm_empresa,  gm_producto, gm_cuenta


                   insert into cb_tmp_gmfmovsum (gm_proceso, gm_opcion, gm_empresa, gm_producto, gm_debito,
                               gm_credito, gm_cuenta, gm_fecha_ini, gm_fecha_fin, gm_fecha_proc)
                   select  gm_proceso, gm_opcion, gm_empresa, gm_producto, 
                   0,
                   sum(gm_credito),
                   gm_cuenta, 
                   @i_fecha_ini,
                   @i_fecha_fin,
                   getdate()
                   from  cb_tmp_gmfmov
                   where gm_opcion = @i_opcion
                   and   gm_fecha_tran >= @i_fecha_ini
                   and   gm_fecha_tran <= @i_fecha_fin
                   group by gm_proceso, gm_opcion, gm_empresa,  gm_producto, gm_cuenta

                   
                   end
               
               end  -- fin @i_proceso != 6021
                  
             
          end  -- si @i_tipo = 'CM' 
          
end -- fin frontend = 'N'

if @i_frontend = 'S'    
begin

--print 'Seleccionando datos de la opción %1!' , @i_opcion


  if @i_opcion  =  1 -- Consulta por producto  en el anexo

  begin

     select gm_producto, gm_dsc_producto = ( select pd_descripcion 
                                       from cobis..cl_producto 
                                       where pd_producto = a.gm_producto), 
            sum(gm_debito) debito, sum(gm_credito) credito
     from cb_tmp_gmfmovsum  a
     where gm_proceso = @i_proceso
     and gm_opcion = @i_opcion 
     and gm_empresa = @i_empresa
     and gm_fecha_ini = @i_fecha_ini
     and gm_fecha_fin = @i_fecha_fin
     group by gm_producto

 
   end  -- opcion  1
   

   
  if @i_opcion  =  2 -- -- Consulta por cuenta  en el anexo

  begin
    
    select  gm_cuenta, gm_dsc_cuenta = (select  cu_nombre from  cob_conta..cb_cuenta
                              where  cu_empresa = @i_empresa
                              and cu_cuenta = a.gm_cuenta), 
                              sum(gm_debito) debito, sum(gm_credito) credito
    from cb_tmp_gmfmovsum a
    where  gm_proceso = @i_proceso
    and    gm_opcion = @i_opcion 
    and    gm_empresa = @i_empresa
    and    gm_fecha_ini = @i_fecha_ini
    and    gm_fecha_fin = @i_fecha_fin
    group by gm_cuenta

  end  -- end opcion 2


if  @i_opcion in ( 3, 4, 6, 7)  -- consulta por producto y cuenta en el anexo

begin

   select  gm_producto,  gm_dsc_producto =  (select  pd_descripcion from 
                         cobis..cl_producto 
                         where pd_producto = a.gm_producto),   
                         gm_cuenta,
                         sum(gm_debito) debito, sum(gm_credito) credito
   from cb_tmp_gmfmovsum a
   where gm_proceso = @i_proceso
   and gm_opcion = @i_opcion 
   and gm_empresa = @i_empresa
   and gm_fecha_ini = @i_fecha_ini
   and gm_fecha_fin = @i_fecha_fin
   group by gm_producto, gm_cuenta

end --end opcion 



if @i_opcion  =   5 -- consulta de datos de aplicativo cta cte y ahorros del anexo 3

begin


--La consulta se debe hacer sobre la tabla  cb_tmp_gmfaplsum

   select   gm_dsc_programa, gm_impuesto, gm_devolucion, gm_producto
     from cb_tmp_gmfaplsum
     where gm_proceso = @i_proceso
     and gm_opcion =  @i_opcion
     and gm_empresa = @i_empresa
     and gm_fecha_ini = @i_fecha_ini
     and gm_fecha_fin = @i_fecha_fin
     order by gm_producto


end


end -- end front end = 'S'

return 0

end


go

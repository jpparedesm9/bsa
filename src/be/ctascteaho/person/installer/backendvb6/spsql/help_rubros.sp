use cob_remesas
/****************************************************************************/
/*     Archivo:     help_rubros.sp                                          */
/*     Stored procedure: sp_help_rubros                                     */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
go
if exists (select
             1
           from   sysobjects
           where  name = 'sp_help_rubros')
  drop proc sp_help_rubros
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go
create proc sp_help_rubros(
   @s_ssn	int,
   @s_srv	varchar(30)=null,
   @s_lsrv      varchar(30)=null,
   @s_user	varchar(30)=null,
   @s_sesn      int,
   @s_term	varchar(10),
   @s_date	datetime,
   @s_org       char (1),
   @s_ofi	smallint,
   @s_rol       smallint =1,
   @s_org_err   char(1)=null,
   @s_error     int = null,
   @s_sev       tinyint = null,
   @s_msg       mensaje = null,  
   @t_debug	char(1)='N',
   @t_file	varchar(14)=null,
   @t_from	varchar(32)=null,
   @t_rty       char(1)='N',
   @t_trn       smallint,
   @i_filial    tinyint = null,
   @i_sucursal  smallint = null,
   @i_modo      tinyint=null,
   @i_codigo    smallint=null,
   @i_tipo      char (1)
)
as
declare @w_sp_name varchar(32),
	@w_return  int
select @w_sp_name = 'sp_help_rubros'

if @t_debug = 'S'
begin 
    exec cobis..sp_begin_debug @t_file=@t_file
      select '/**Store Procedure**/' = @w_sp_name,  
	s_ssn 	        = @s_ssn,
	s_srv		= @s_srv,
	s_lsrv   	= @s_lsrv,
	s_user  	= @s_user,
    s_sesn          = @s_sesn,
	s_term 		= @s_term,
	s_date   	= @s_date,
    s_org           = @s_org,
	s_ofi    	= @s_ofi,
    s_rol           = @s_rol,
    s_org_err       = @s_org_err,
    s_error         = @s_error,
    s_sev           = @s_sev,
    s_msg           = @s_msg,
    t_debug         = @t_debug, 
	t_file		= @t_file,
	t_from	 	= @t_from,
    t_rty           = @t_rty,
	i_modo		= @i_modo,
	i_filial	= @i_filial,
	i_sucursal      = @i_sucursal,
        i_tipo          = @i_tipo,
        i_codigo        = @i_codigo 
    exec cobis..sp_end_debug
end

    if @t_trn !=4046 
        begin
        	/*Error en codigo de transaccion*/

    	        exec cobis..sp_cerror
    		   @t_debug = @t_debug,
    		   @t_file  = @t_file,
    		   @t_from  = @w_sp_name,
                   @i_num   = 351516      
     	        return 351516
 	end
if @i_tipo = 'A'
begin
 set rowcount 15
    select '1093'               = sp_servicio_per,                --CODIGO
           '1203'               = substring(vs_descripcion,1,35), --DESCRIPCION DEL SERVICIO
	       '1751'               = sp_tipo_rango,                  --TIPO DE RANGO
	       '1665'               = sp_pro_final,                   --PRODUCTO FINAL
	       '1200'               = substring(pf_descripcion,1,35), --DESCRIPCION DEL PROD. FIN.
	       '1750'               = vs_tipo_dato                    --TIPO DE DATO
    from pe_servicio_per,pe_var_servicio,pe_pro_final
      where vs_servicio_dis = sp_servicio_dis     
	and vs_rubro = sp_rubro
  	and pf_pro_final = sp_pro_final
  	and pf_filial = @i_filial
	and pf_sucursal = @i_sucursal
        and sp_servicio_per > @i_codigo
    order by sp_servicio_per
set rowcount 0
return 0
end

 if @i_tipo = 'V'
    begin
    select substring(vs_descripcion,1,35),
	   sp_tipo_rango,
	   sp_pro_final,
	   substring(pf_descripcion,1,35),
	   vs_tipo_dato
    from pe_servicio_per,pe_var_servicio,pe_pro_final
    where vs_servicio_dis = sp_servicio_dis     
	  and vs_rubro = sp_rubro
	  and pf_pro_final = sp_pro_final
	  and pf_filial = @i_filial
	  and pf_sucursal = @i_sucursal
          and sp_servicio_per = @i_codigo
          if @@rowcount =0
          begin
          /*no existe servicio personalizable */
            exec cobis..sp_cerror
	    @t_debug = @t_debug,
	    @t_file  = @t_file,
	    @t_from  = @w_sp_name,
            @i_num   = 351515      
          return 351515
          end
set rowcount 0
return 0
end
go




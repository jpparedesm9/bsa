/************************************************************************/
/*  Archivo:            tr_crea_acciond.sp                              */
/*  Stored procedure:   sp_tr_crea_acciond                              */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           REmesas                                         */
/*  Disenado por:                                                       */
/*  Fecha de escritura:                                                 */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*                                                                      */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA          AUTOR           RAZON                                */
/*  23/Junio/2016  Walther Toledo  Mantenimiento de Acciones de ND      */
/************************************************************************/

use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_crea_acciond')
  drop proc sp_tr_crea_acciond
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

CREATE proc sp_tr_crea_acciond (
	@s_ssn		      int,
	@s_srv		      varchar(30),
	@s_lsrv		      varchar(30),
	@s_user		      varchar(30),
	@s_sesn		      int,
	@s_term		      varchar(10),
	@s_date		      datetime,
	@s_ofi		      smallint,
	@s_rol		      smallint = 1,
	@s_org_err	      char(1)  = null,
	@s_error	      int      = null,
	@s_sev		      tinyint  = null,
	@s_msg		      mensaje  = null,
	@s_org		      char(1),
	@t_debug	      char(1) = 'N',
	@t_file		      varchar(14) = null,
	@t_from		      varchar(32) = null,
	@t_rty		      char(1) = 'N',
	@t_trn		      smallint,
    @i_tran           char(1) = 'M',
    @i_causal         varchar(3), 
	@i_producto       tinyint = null,
    @i_accion         char(1) = null,
	@i_comision	      char(1) = null,  
    @i_impuesto       char(1) = null,
    @i_saldomin       char(1) = null
)
as
declare
        @w_return	      int,
	    @w_sp_name	      varchar(30),
        @w_estado         char(1),
        @v_estado         char(1),
        @w_tabla          varchar(25)


/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_crea_acciond'

/*  Activacion del Modo de debug  */

if @t_debug = 'S'
  begin
	exec cobis..sp_begin_debug @t_file=@t_file
	select	'/**  Stored Procedure  **/ ' = @w_sp_name,
		s_ssn 		= @s_ssn,
		s_srv 	    = @s_srv,
		s_lsrv 	    = @s_lsrv,
		s_user 		= @s_user,
		s_sesn 	    = @s_sesn,
		s_term 		= @s_term,
		s_date 		= @s_date,
		s_ofi	 	= @s_ofi,
		s_rol 		= @s_rol,
		s_org_err 	= @s_org_err,
		s_error 	= @s_error,
		s_sev   	= @s_sev,
		s_msg 		= @s_msg,
		s_ori		= @s_org,	
		t_from 		= @t_from,
		t_file		= @t_file, 
		t_rty 		= @t_rty,
		t_trn		= @t_trn,
		i_product   = @i_producto,
		i_causal	= @i_causal,
	    i_accion    = @i_accion
	exec cobis..sp_end_debug
  end

if @t_trn = 700                /*    Consulta de Registros    */ 
begin

    if @i_tran = 'M'

      begin
        if @i_producto = 3
           select @w_tabla = 'cc_causa_nd'
          else
             select @w_tabla = 'ah_causa_nd'

        set rowcount 20

        select 'PRODUCTO'            = an_producto,
               'CAUSAL'              = an_causa,
               'DESC. CAUSAL'        = substring(valor,1,45),
               'ACCION'              = an_accion,
	           'IVA'                 = an_comision,   
               'IMPUESTO GMF'        = an_impuesto,
               'VALIDA SALDO MINIMO' = an_saldomin
        from cob_remesas..re_accion_nd,
             cobis..cl_tabla x, 
             cobis..cl_catalogo y
        where an_producto = @i_producto 
          and x.tabla  = @w_tabla 
          and x.codigo = y.tabla 
          and y.codigo = an_causa
          and an_causa > @i_causal
        order by an_causa
        
        if @@rowcount = 0 and @i_causal = '0'
        begin
          exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 351048
          return 1
        end

        set rowcount 0
      end   

    if @i_tran = 'S'
      begin

        set rowcount 20

          select 'PRODUCTO'     = an_producto 
            from cob_remesas..re_accion_nd with(nolock)
           where an_causa = @i_causal
             /*  and an_producto <> 5  */ 
    
        set rowcount 0
      end

    if @i_tran = 'V'
    begin

        set rowcount 20

          select 'CAUSAL'  = an_causa 
            from cob_remesas..re_accion_nd with(nolock)
           where an_producto = @i_producto 
             and an_causa = @i_causal
    
         if @@rowcount = 0
         begin
             /* Error en consultar accion nota de debito */
             exec cobis..sp_cerror
                  @t_debug	 = @t_debug,
                  @t_file	 = @t_file,
                  @t_from	 = @w_sp_name,
                  @i_num	 = 201147
             return 201147
         end

        set rowcount 0
    end
end

if @t_trn = 698                /*   Creacion del registro    */

  begin

    begin tran

     /* Valida Duplicados */
     if exists (select *
                from cob_remesas..re_accion_nd
                where an_producto = @i_producto
                  and an_causa    = @i_causal)
        begin 
           exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 351047
           return 351047
        end
 
     /* Registro en la Tabla */ 
     
     insert into cob_remesas..re_accion_nd
                  (an_producto, an_causa, an_accion, an_comision, an_impuesto,  an_saldomin, an_modo)
         values   (@i_producto, @i_causal, @i_accion, @i_comision, @i_impuesto, @i_saldomin, 'S')
     if @@error <> 0
        begin
          exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 203030
          return 203030
        end

    /* Creacion de Transaccion de Servicio */
        
       insert into cob_remesas..re_ts_causales_impuestos 
		  	  (secuencial, tipo_transaccion, fecha, causa, referencia,
			   usuario, terminal, oficina, producto, hora)
       values (@s_ssn, @t_trn, @s_date, @i_causal, @i_accion + ',' + @i_comision + ',' + @i_impuesto,
               @s_user, @s_term,@s_ofi, @i_producto, getdate())
    
    /* Error en creacion de transaccion de servicio */

       if @@error <> 0
          begin
             exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
        end

    commit tran

  end

if @t_trn = 701                   /*  Eliminacion del  Registro  */
  begin

    select @w_estado      = an_accion
      from cob_remesas..re_accion_nd
     where an_producto = @i_producto
       and an_causa = @i_causal
       and an_comision = @i_comision  
           
    if @@rowcount <> 1
      begin
        /* Accion de notas de debito invalido */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 201147
        return 201147
      end

    begin tran

      delete cob_remesas..re_accion_nd
       where an_producto = @i_producto
         and an_causa        = @i_causal
	 and an_comision = @i_comision  

       if @@rowcount <> 1
         begin
           /* Error en eliminacion accion de notas de debito */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 207011
           return 207011
         end


     /* Creacion de Transaccion de Servicio */

       insert into cob_remesas..re_ts_causales_impuestos 
	 		  (secuencial, tipo_transaccion, fecha, causa, referencia,
			   usuario, terminal, oficina, producto, hora)
       values (@s_ssn, @t_trn, @s_date, @i_causal, @i_accion + ',' + @i_comision + ',' + @i_impuesto + ',' + @i_saldomin,
               @s_user, @s_term, @s_ofi, @i_producto, getdate())
                                   

    /* Error en creacion de transaccion de servicio */

    if @@error <> 0
      begin
        /* Error en creacion de transaccion de servicio */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 203005
             return 203005
          end

    commit tran
  end

if @t_trn = 699                   /*  Actualizacion Registro  */
begin

    select @w_estado      = an_accion
      from cob_remesas..re_accion_nd
     where an_producto = @i_producto
       and an_causa = @i_causal
           
    if @@rowcount <> 1
      begin
        /* Accion de notas de debito invalido */
        exec cobis..sp_cerror
             @t_debug	 = @t_debug,
             @t_file	 = @t_file,
             @t_from	 = @w_sp_name,
             @i_num	 = 201147
        return 201147
      end

    select @v_estado = @w_estado

    /* Verificacion de los campos permisibles de autorizacion */


    if @w_estado = @i_accion
      begin
        select @w_estado = null,
               @v_estado = null
      end
    else
      select @w_estado = @i_accion

    begin tran

      update cob_remesas..re_accion_nd
         set an_accion      = @i_accion,
	     an_comision    = @i_comision,
             an_impuesto    = @i_impuesto,
             an_saldomin    = @i_saldomin
       where an_producto = @i_producto
         and an_causa        = @i_causal

       if @@rowcount <> 1
         begin
           /* Error en actualizar accion nota de debito */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 205027
           return 205027
         end

    /* Creacion de Transaccion de Servicio */

       insert into cob_remesas..re_ts_causales_impuestos 
	      	  (secuencial, tipo_transaccion, fecha, causa, referencia,
			   usuario, terminal, oficina, producto, hora)
       values (@s_ssn, @t_trn, @s_date, @i_causal, @i_accion + ',' + @i_comision + ',' + @i_impuesto + ',' + @i_saldomin,
               @s_user, @s_term,@s_ofi, @i_producto, getdate())  

    /* Error en creacion de transaccion de servicio */

       if @@error <> 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
         end

    commit tran
end

  return 0




GO


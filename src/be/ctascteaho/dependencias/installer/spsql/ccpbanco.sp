/************************************************************************/
/*  Archivo:                ccpbanco.sp                                 */
/*  Stored procedure:       sp_tr_crea_banco                            */
/*  Base de datos:          cob_cuentas                                 */
/*  Producto:               Cuentas Corrientes                          */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*  Este programa procesa la transaccion de:                            */
/*  Mantenimiento de Bancos.                                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  05/07/2016      Jorge Salazar   Migracion a CEN                     */
/************************************************************************/
use cob_cuentas
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_tr_crea_banco')
  drop proc sp_tr_crea_banco
go

create proc sp_tr_crea_banco 
(
    @s_ssn            int,
    @s_srv            varchar(30),
    @s_lsrv           varchar(30),
    @s_user           varchar(30),
    @s_sesn           int,
    @s_term           varchar(10),
    @s_date           datetime,
    @s_ofi            smallint,
    @s_rol            smallint = 1,
    @s_org_err        char(1)  = null,
    @s_error          int      = null,
    @s_sev            tinyint  = null,
    @s_msg            varchar(240) = null,
    @s_org            char(1),
    @t_debug          char(1) = 'N',
    @t_file           varchar(14) = null,
    @t_from           varchar(32) = null,
    @t_rty            char(1)     = 'N',
    @t_trn            smallint,
    @t_show_version   bit = 0,
    @i_tran           char(1)     = null,
    @i_banco          smallint    = null,
    @i_desc	          varchar(64) = null,
    @i_filial         tinyint     = null,
    @i_estado         char(1)     = null,
    @i_nit            varchar(13) = null
)
as
declare
    @w_return         int,
    @w_sp_name        varchar(30),
    @w_descripcion    varchar(64),
    @w_estado         char(1),
    @w_filial         tinyint,
    @w_ente           int

/*  Captura nombre de Stored Procedure  */

select	@w_sp_name = 'sp_tr_crea_banco'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

/*  Activacion del Modo de debug  */


if @t_trn = 2595                /*      Consulta     */

  begin

    if @i_tran = 'Q'

      begin
      set rowcount 20
      select '509139' = ba_banco,
             '503196' = substring(ba_descripcion,1,30),
             '509140' = ba_filial,
             '509141' = substring(valor,1,20),
             '9019'   = ba_estado,
             '509142' = ba_nit
      from cob_remesas..re_banco,
           cobis..cl_tabla x, 
           cobis..cl_catalogo y
      where ba_banco > @i_banco 
        and x.tabla  = 'cl_filial'
        and x.codigo = y.tabla 
        and y.codigo = convert(char(1),ba_filial)
        set rowcount 0 
      end

    if @i_tran = 'S'

      begin
        set rowcount 20
        select '508961' = ba_banco,
               '503196' = substring(ba_descripcion,1,30)
        from cob_remesas..re_banco
        where ba_filial = @i_filial
        set rowcount 0
      end

    if @i_tran = 'V'

      begin
        set rowcount 20
        select '503196' = substring(ba_descripcion,1,30)
        from cob_remesas..re_banco
        where ba_banco = @i_banco 
        if @@rowcount = 0
           begin
             /* Error en consulta de banco */
             exec cobis..sp_cerror
                  @t_debug	 = @t_debug,
                  @t_file	 = @t_file,
                  @t_from	 = @w_sp_name,
                  @i_num	 = 201149
             return 201149
           end
        set rowcount 0
      end

  end

if @t_trn = 2593                   /*    Crear Registros          */
begin
	/* Valida existencia del Banco */
	if exists (	select *
			  from cob_remesas..re_banco
			 where ba_banco = @i_banco)
	begin
		exec cobis..sp_cerror
			@t_debug	 = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 351047
		return 351047
	end


	select @w_ente = isnull(en_ente,0)
	  from cobis..cl_ente
	 where en_subtipo  = 'C' 	/*  Compania */
	   and en_ced_ruc  =  @i_nit	/*  Num Doc  */
	   and en_tipo_ced = 'N'	/*  Nit	     */

	if @w_ente = 0
	begin
		/* No existe cliente */
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 101146
		return 101146
	end

	/* NIT especificado ya existe  */
	if exists (	select *
			  from cob_remesas..re_banco
			 where ba_nit = @i_nit)
	begin
		exec cobis..sp_cerror
			@t_debug	 = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 101105
		return 101105
	end


                     
	insert into cob_remesas..re_banco 
		(ba_banco, ba_filial, ba_descripcion, ba_estado, ba_nit, ba_ente)
	values  (@i_banco, @i_filial, @i_desc, @i_estado, @i_nit, @w_ente) 
	
	if @@error != 0
	begin
		/* Error en creacion de Banco */
		exec cobis..sp_cerror
			@t_debug	 = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 203031
		return 203031
	end

    /* Creacion de Transaccion de Servicio */

       insert into cob_cuentas..cc_tran_servicio
				(ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
				 ts_usuario,ts_terminal, ts_oficina, ts_hora)
                         values (@s_ssn, @t_trn, @s_date, @s_user, @s_term, 
                                 @s_ofi, getdate()) 

    /* Error en creacion de transaccion de servicio */

       if @@error != 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
          end

end               

if @t_trn = 2596            /*     Eliminacion de Registros     */

  begin
      /* Valida existencia del Banco */
     if not exists (select *
                from cob_remesas..re_banco
                where ba_banco = @i_banco)
        begin
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 351049
          return 351049
        end 

     delete cob_remesas..re_banco
     where ba_banco = @i_banco
       if @@rowcount != 1
         begin
           /* Error eliminacion banco */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 207012
           return 207012
         end

    /* Creacion de Transaccion de Servicio */

       insert into cob_cuentas..cc_tran_servicio
				(ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
				 ts_usuario,ts_terminal, ts_oficina, ts_hora)
                         values (@s_ssn, @t_trn, @s_date, @s_user, @s_term, 
                                 @s_ofi, getdate()) 

    /* Error en creacion de transaccion de servicio */

       if @@error != 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
          end
end

if @t_trn = 2594            /*     Actualizacion Registros     */

  begin
   /* Valida existencia del Banco */
     if not exists (select *
                from cob_remesas..re_banco
                where ba_banco = @i_banco)
        begin
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 351049
          return 351049
        end                    


	select @w_ente = isnull(en_ente,0)
	  from cobis..cl_ente
	 where en_subtipo  = 'C' 	/*  Compania */
	   and en_ced_ruc  =  @i_nit	/*  Num Doc  */
	   and en_tipo_ced = 'N'	/*  Nit	     */

	if @w_ente = 0
	begin
		/* No existe cliente */
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 101146
		return 101146
	end

      update cob_remesas..re_banco 
         set ba_descripcion = @i_desc,
             ba_filial      = @i_filial,
             ba_estado      = @i_estado,
	     ba_nit	    = @i_nit,
	     ba_ente	    = @w_ente
       where ba_banco = @i_banco
       if @@rowcount != 1
         begin
           /* Error actualizacion Banco */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 205028
           return 205028
         end

    /* Creacion de Transaccion de Servicio */

       insert into cob_cuentas..cc_tran_servicio
				(ts_secuencial, ts_tipo_transaccion, ts_tsfecha, 
				 ts_usuario,ts_terminal, ts_oficina, ts_hora)
                         values (@s_ssn, @t_trn, @s_date, @s_user, @s_term, 
                                 @s_ofi, getdate()) 

    /* Error en creacion de transaccion de servicio */

       if @@error != 0
          begin
             exec cobis..sp_cerror
                @t_debug	 = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 203005
             return 203005
          end

  end       

  return 0
go


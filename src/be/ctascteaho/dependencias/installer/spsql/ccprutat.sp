/************************************************************************/
/*  Archivo:                ccprutat.sp                                 */
/*  Stored procedure:       sp_tr_crea_rutayt                           */
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
/*  Mantenimiento de Ruta y Transito.                                  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  04/07/2016      Jorge Salazar   Migracion a CEN                     */
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
           where  name = 'sp_tr_crea_rutayt')
  drop proc sp_tr_crea_rutayt
go

create proc sp_tr_crea_rutayt (
    @s_ssn            int,
    @s_srv	          varchar(30),
    @s_lsrv	          varchar(30),
    @s_user	          varchar(30),
    @s_sesn	          int,
    @s_term	          varchar(10),
    @s_date	          datetime,
    @s_ofi	          smallint,
    @s_rol	          smallint = 1,
    @s_org_err        char(1)  = null,
    @s_error          int      = null,
    @s_sev	          tinyint  = null,
    @s_msg	          varchar(240)  = null,
    @s_org	          char(1),
    @t_debug          char(1) = 'N',
    @t_file	          varchar(14) = null,
    @t_from	          varchar(32) = null,
    @t_rty	          char(1) = 'N',
    @t_trn	          smallint,
    @t_show_version   bit = 0,
    @i_localidad      smallint,
    @i_localidad_a    smallint = null,
    @i_tran           char(1)  = null,
    @i_tipo           char(1)  = null,
    @i_banco_p        tinyint  = null,
    @i_oficina_p      smallint = null,
    @i_ciudad_p       int = null,
    @i_banco_c        tinyint  = null,
    @i_ciudad_c       int = null,
    @i_oficina_c      smallint = null,
    @i_num_dias       tinyint  = null,
    @i_ultimo         int      = null,
    @i_causacont      varchar(3) = null 
)
as
declare
    @w_return	      int,
    @w_sp_name	      varchar(30),
    @w_localidad      smallint, 
    @w_num_dias       tinyint,
    @w_siguiente      int

/*  Captura nombre de Stored Procedure  */
select @w_sp_name = 'sp_tr_crea_rutayt'
   
---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
  print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
  return 0
end

/*  Activacion del Modo de debug  */

if @t_trn = 2587         /* Consultas */

  begin

    if @i_tran = 'C'     /* Corresponsales para la Localidad Origen */

      begin
          set rowcount 20
          select '509117' = tn_banco_p,
                 '509118' = substring(x.ba_descripcion,1,20) + '  '
                          + substring(z.ci_descripcion,1,15),
                 '509119' = tn_oficina_p,
                 '509120' = tn_ciudad_p,
                 '509121' = tn_banco_c,
                 '509122' 
                          = substring(y.ba_descripcion,1,25) + '  '
                          + substring(w.ci_descripcion,1,15), 
                 '509123' = tn_oficina_c,
                 '509124' = tn_ciudad_c,
                 '509125' = tn_num_dias,
                 '509126' = tn_secuencial,
                 '509127' = tn_causa_contab
          from cob_remesas..re_transito --, cob remesas..re_banco x,
               LEFT OUTER JOIN cob_remesas..re_banco y ON tn_banco_c = y.ba_banco --cob_remesas..re_banco x,
               LEFT OUTER JOIN cobis..cl_ciudad z ON tn_ciudad_p = z.ci_cod_remesas --cob_remesas..re_banco y,
               LEFT OUTER JOIN cobis..cl_ciudad w ON tn_ciudad_c = w.ci_cod_remesas, --cobis..cl_ciudad z,
               cob_remesas..re_banco x --cobis..cl_ciudad w
          where tn_nombre      = @i_localidad
            and tn_banco_p     = x.ba_banco 
            --and tn_ciudad_p   *= z.ci_cod_remesas
            --and tn_banco_c    *= y.ba_banco
            --and tn_ciudad_c   *= w.ci_cod_remesas
            and tn_secuencial  > @i_ultimo
          order by tn_secuencial, tn_banco_p
          if @@rowcount = 0
             begin
                exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 351048
                return 351048
             end
          set rowcount 0  
      end

      if @i_tran = 'L'      /* Consulta de la Localidad de Origen */     
      
         if @i_tipo = 'A'   /* Todas las Localidades */
         
            begin
               set rowcount 20
               select '9919'      = ci_cod_remesas,
                      '9942' = substring(ci_descripcion,1,35)
               from cobis..cl_ciudad
               where ci_cod_remesas > @i_ultimo
               order by ci_cod_remesas
               if @@rowcount = 0
                  begin
                     exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file	 = @t_file,
                        @t_from	 = @w_sp_name,
                        @i_num	 = 201150
                     return 201150
                  end
                set rowcount 0
             end

             else  /* Consulta particular */
 
               begin
                  select '9942' = ci_descripcion
                  from cobis..cl_ciudad
                  where ci_cod_remesas = @i_localidad
                  if @@rowcount = 0
                     begin
                        exec cobis..sp_cerror
                           @t_debug	 = @t_debug,
                           @t_file	 = @t_file,
                           @t_from	 = @w_sp_name,
                           @i_num	 = 201150
                        return 201150
                     end
                end
   end
          
 
if @t_trn = 2585       /* Crear Regitros */            

  begin
  /* Valida Existencia Banco Propietario */
     if not exists (select ba_banco 
                    from cob_remesas..re_banco
                    where ba_banco = @i_banco_p)
        begin
            exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num = 201159 
            return 201159
        end
    
	/* Valida Existencia Banco Corresponsal */
	if @i_banco_c is not null
	begin
		if not exists (select ba_banco 
        	            from  cob_remesas..re_banco  
                	    where ba_banco = @i_banco_c)
	        begin           
			exec cobis..sp_cerror
				@t_debug	 = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num = 201160 
			return 201160
        	end
	end
     /* Valida existencia en Transito */
      if exists(select *
                from cob_remesas..re_transito
                where tn_nombre    = @i_localidad 
                  and tn_banco_p   = @i_banco_p
                  and tn_oficina_p = @i_oficina_p
                  and tn_ciudad_p  = @i_ciudad_p)
          begin           
            exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num = 351047 
            return 351047
           end

      /* Genera secuencial para la insercion en la tabla */
       select @w_siguiente = max(tn_secuencial)
       from cob_remesas..re_transito
       
       if @w_siguiente = NULL
          select @w_siguiente = 1
        else
           select @w_siguiente = @w_siguiente + 1
 
       /* Registro en la tabla */
       insert into cob_remesas..re_transito 
              (tn_nombre, tn_banco_p, tn_oficina_p, 
               tn_ciudad_p, tn_banco_c, tn_oficina_c,
               tn_ciudad_c, tn_num_dias, tn_secuencial, tn_causa_contab) 
      values  (@i_localidad, @i_banco_p, @i_oficina_p,
               @i_ciudad_p, @i_banco_c, @i_oficina_c,
               @i_ciudad_c, @i_num_dias, @w_siguiente, @i_causacont) 
      if @@error != 0
        begin
          exec cobis..sp_cerror
               @t_debug	 = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 203032
          return 203032
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

if @t_trn = 2588      /* Eliminacion de Registros */       

  begin
      /* Valida existencia en Transito */
      if not exists(select *
                from cob_remesas..re_transito
                where tn_nombre    = @i_localidad
                  and tn_banco_p   = @i_banco_p
                  and tn_oficina_p = @i_oficina_p
                  and tn_ciudad_p  = @i_ciudad_p)
          begin
            exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num = 351049
            return 351049
           end        

      delete cob_remesas..re_transito 
      where tn_nombre     = @i_localidad  
       and  tn_banco_p    = @i_banco_p
       and  tn_oficina_p  = @i_oficina_p  
       and  tn_ciudad_p   = @i_ciudad_p
       if @@rowcount != 1
         begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 207013
           return 207013
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

if @t_trn = 2586       /* Actualizacion de Registros */  

  begin
      update cob_remesas..re_transito 
         set tn_nombre   = @i_localidad,
             tn_num_dias = @i_num_dias,
	     tn_causa_contab = @i_causacont
      where tn_nombre    = @i_localidad_a
       and  tn_banco_p   = @i_banco_p
       and  tn_oficina_p = @i_oficina_p
       and tn_ciudad_p   = @i_ciudad_p
       if @@rowcount != 1
         begin
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file	 = @t_file,
                @t_from	 = @w_sp_name,
                @i_num	 = 205029
           return 205029
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


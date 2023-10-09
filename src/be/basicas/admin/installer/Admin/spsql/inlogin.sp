/************************************************************************/
/*      Archivo:                inlogin.sp                              */
/*      Stored procedure:       sp_inlogin                              */
/*      Base de datos:          cobis                                   */
/*      Producto:               Administracion                          */
/*      Disenado por:           Isaac Torres                            */
/*      Fecha de escritura:     31-May-2012                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa es usado para el desbloqueo de funcionarios       */
/*      Actualizacion del estado del usuario                            */
/*      Insercion de las transacciones de servicion en la vista         */
/*      ts_desbloqueo_func                                              */
/*                              MODIFICACIONES                          */
/************************************************************************/
/* FECHA    AUTOR    RAZON    NEMONICO        */
/************************************************************************/
/*      31/May/2012     I. Torres       Emision inicial                 */
/*      17/Jul/2012     Pedro Montenegro R INC-CAS-946         */
/*      21/Sep/2012     J. García       correcion del sp_cerror por     */
/*                                      @w_sp_name                      */
/*      24/Jun/2016     J.Hernandez     Ajuste Vesion Falabella cambio  */
/*                                      tipo de dato nodo               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_inlogin')
        drop proc sp_inlogin
go

create proc sp_inlogin (
    @s_ssn          int,
    @s_srv          varchar(30),
    @s_lsrv         varchar(30),
    @s_user         varchar(30),
    @s_sesn         int,
    @s_term         varchar(32),
    @s_date         datetime,
    @s_ofi          smallint,    /* Localidad origen transaccion */
    @s_rol          smallint,
    @s_org_err      char(1)     = null, /* Origen de error:[A], [S] */
    @s_error        int         = null,
    @s_sev          tinyint     = null,
    @s_msg          mensaje     = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_show_version  bit         = 0, -- Mostrar la version del programa    
    @t_from         varchar(32) = null,
    @t_rty          char(1)     = 'N',
    @t_trn          int,
    @i_login        login       = null,
    @i_srv          varchar(30) = null
)
as
declare @w_return               int,
        @w_login                varchar(20),
      @w_sp_name              varchar(32),
      @v_estado               varchar(30), --ITO Guarda el estado del usuario    
      @w_us_filial            tinyint,
      @w_us_oficina           smallint,
      @w_us_nodo              smallint,      
      @w_us_fecha_asig        datetime,
      @w_us_creador           smallint,
      @w_us_fecha_ult_mod     datetime,
      @w_us_fecha_ult_pwd     datetime


if @t_show_version = 1
begin
    print 'Stored procedure sp_inlogin, Version 4.0.0.2'
    return 0
end


select @w_sp_name = 'sp_inlogin'

/* Validacion del tipo de transaccion */
if @t_trn != 15914
begin /* Error en codigo de transaccion */
    exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 107121
    return 1
end

-- FMONCAYOV CONTROL DE SESIONES DE BUZON PARA OFICIALES
-- RVI Modificaciones para el flujo de los usuarios que no existen

--ITO inicializacion de variables para ingresar en la vista 
select @w_us_filial        = us_filial,
   @w_us_oficina        = us_oficina,
   @w_us_nodo           = us_nodo,     
   @w_us_fecha_asig     = us_fecha_asig,
   @w_us_creador        = us_creador,
   @w_us_fecha_ult_mod  = us_fecha_ult_mod,
   @w_us_fecha_ult_pwd  = us_fecha_ult_pwd
from ad_usuario   
where us_login = @i_login

--ITO Obtencion del estado del usuario
select @v_estado = us_estado 
   from ad_usuario
   where us_login = @i_login
   
select @w_login = lo_login
    from cobis..in_login 
    where lo_login   = @i_login
    and lo_fecha_out is null


if @@rowcount > 0
    begin
        /*select @w_login = fu_login
            from cobis..cc_oficial, cobis..cl_funcionario
            where fu_funcionario = oc_funcionario
            and fu_login = @i_login

        if @@rowcount > 0
            begin
                --print "LOGIN PERTENECE A UN OFICIAL, UTILICE EL BUZON PARA DESBLOQUEARSE"
                exec cobis..sp_cerror  -- RVI 21/Abr/2009
                    @t_debug     = @t_debug,
                    @t_file      = @t_file,
                    @i_from      = 'sp_inlogin',
                    @i_num       = 107201

                exec cobis..sp_cerror  -- RVI 21/Abr/2009
                    @t_debug     = @t_debug,
                    @t_file      = @t_file,
                    @t_from      = 'sp_inlogin',
                    @i_num       = 107202
                return 1
            end
        else*/
         begin tran
      
            update cobis..in_login 
               set lo_fecha_out = getdate()
               where lo_login      = @i_login
               and lo_fecha_out is null
                        
                if @@rowcount > 0 
                    begin           
                        update cobis..ad_usuario 
                            set us_estado = 'V'
                            where us_login = @i_login
                            and us_estado = 'B'
                     
                  /* transaccion de servicio - Previo Actualizacion*/   
                  insert into ts_desbloqueo_func (secuencia, tipo_transaccion, clase, fecha,
                                    oficina_s, usuario, terminal_s, srv, lsrv,
                                    filial, oficina, nodo, login, 
                                    fecha_asig, creador, estado, fecha_ult_mod)
                              values (@s_ssn, 15914, 'P', @s_date,
                                    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
                                    @w_us_filial, @w_us_oficina, @w_us_nodo, @i_login,
                                    @w_us_fecha_asig, @w_us_creador, @v_estado, getdate())                                    
   
                  if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 103005
                     /*  'Error en creacion de transaccion de servicio' */
                     return 1
                  end
                  
                  /* transaccion de servicio - Actualizacion */
                  insert into ts_desbloqueo_func (secuencia, tipo_transaccion, clase, fecha,
                                    oficina_s, usuario, terminal_s, srv, lsrv,
                                    filial, oficina, nodo, login, 
                                    fecha_asig, creador, estado, fecha_out,
                                    fecha_ult_mod)
                              values (@s_ssn, 15914, 'A', @s_date,
                                    @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
                                    @w_us_filial, @w_us_oficina, @w_us_nodo, @i_login,
                                    @w_us_fecha_asig, @w_us_creador, 'V', getdate(), 
                                     getdate())                
                  
                  if @@error != 0
                  begin
                     exec sp_cerror
                        @t_debug      = @t_debug,
                        @t_file       = @t_file,
                        @t_from       = @w_sp_name,
                        @i_num        = 103005
                     /*  'Error en creacion de transaccion de servicio' */
                     return 1
                  end                     
                    end             
               else 
                  return 0            
         commit tran
    end
else
   begin

      if exists(select 1 from ad_usuario
               where us_login = @i_login
               and us_estado = 'B')
         begin
             
            update cobis..ad_usuario 
                            set us_estado = 'V'
                            where us_login = @i_login
                            and us_estado = 'B'
                     
            /* transaccion de servicio - Previo Actualizacion*/   
            insert into ts_desbloqueo_func (secuencia, tipo_transaccion, clase, fecha,
                              oficina_s, usuario, terminal_s, srv, lsrv,
                              filial, oficina, nodo, login, 
                              fecha_asig, creador, estado, fecha_ult_mod)
                        values (@s_ssn, 15914, 'P', @s_date,
                              @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
                              @w_us_filial, @w_us_oficina, @w_us_nodo, @i_login,
                              @w_us_fecha_asig, @w_us_creador, @v_estado, getdate())                                    
   
            if @@error != 0
            begin
               exec sp_cerror
                  @t_debug      = @t_debug,
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 103005
               /*  'Error en creacion de transaccion de servicio' */
               return 1
            end
               
            /* transaccion de servicio - Actualizacion */
            insert into ts_desbloqueo_func (secuencia, tipo_transaccion, clase, fecha,
                              oficina_s, usuario, terminal_s, srv, lsrv,
                              filial, oficina, nodo, login, 
                              fecha_asig, creador, estado, fecha_out,
                              fecha_ult_mod)
                        values (@s_ssn, 15914, 'A', @s_date,
                              @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,   
                              @w_us_filial, @w_us_oficina, @w_us_nodo, @i_login,
                              @w_us_fecha_asig, @w_us_creador, 'V', getdate(), 
                               getdate())                
                  
            if @@error != 0
            begin
               exec sp_cerror
                  @t_debug      = @t_debug,
                  @t_file       = @t_file,
                  @t_from       = @w_sp_name,
                  @i_num        = 103005
               /*  'Error en creacion de transaccion de servicio' */
               return 1
            end   
         end
      else
         begin    
                           
            exec cobis..sp_cerror   -- RVI 21/Abr/2009
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_num       = 107203
            return 1
         end
    end
go



use cob_interfase
go

if exists (select 1 from sysobjects where  name = 'sp_icomext')
   drop proc sp_icomext
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

create proc sp_icomext (
       @s_ssn               int             = NULL,
       @s_date              datetime        = NULL,
       @s_term              varchar(30)     = NULL,
       @s_sesn              int             = NULL,
       @s_srv               varchar(30)     = NULL,
       @s_lsrv              varchar(30)     = NULL,
       @s_user              varchar(30)     = NULL,
       @s_ofi               smallint        = NULL,
       @s_rol               smallint        = NULL,
       @s_ssn_corr          int             = NULL,
       @s_org               char(1)         = NULL,
       @s_ssn_branch        int             = NULL,
       @t_debug             char(1)         = NULL,
       @t_file              varchar(14)     = NULL,
       @t_trn               smallint        = NULL,
       @t_corr              char(1)         = 'N', 
       @t_ssn_corr          int             = NULL, 
       @i_operacion         varchar(2)      = NULL,
       @i_tipo              char(1)         = NULL,
       @i_tope              varchar(3)      = NULL,
       @i_concep            varchar(3)      = NULL,
       @i_opesba            int             = NULL,   
       @i_secsba            int             = NULL,       
       @i_modulo            int             = NULL,
       @i_catego            char(1)         = NULL,
       @i_notifi            varchar(255)    = NULL,
       @i_fechem            datetime        = NULL,
       @i_fechac            datetime        = NULL,
       @i_ordena            int             = NULL,     
       @i_nomord            varchar(255)    = NULL,
       @i_porcde            varchar(255)    = NULL,
       @i_dirpcd            varchar(255)    = NULL,
       @i_dirord            varchar(255)    = NULL,
       @i_cedruc            varchar(24)     = NULL,  
       @i_dirben            varchar(255)    = NULL,
       @i_import            money           = NULL,
       @i_moneda            int             = NULL,
       @i_benefi            varchar(255)    = NULL,
       @i_ref_opc           varchar(34)     = NULL,
       @i_conben            varchar(3)      = NULL,
       @i_paiben            smallint        = NULL,
       @i_ciuben            smallint        = NULL,
       @i_bcoben            smallint        = NULL,
       @i_ofiben            smallint        = NULL,
       @i_tdirben           char(1)         = NULL,
       @i_instruccion1      varchar(255)    = NULL,
       @i_nomben            varchar(255)    = NULL,
       @i_bcoint            smallint        = NULL,
       @i_ofiint            smallint        = NULL,
       @i_tdirint           char(1)         = NULL,
       @i_nomint            varchar(64)     = NULL,
       @i_operacionpf       int             = NULL,
       @i_tr_cod_transf     int             = NULL,
       @i_opeban            varchar(24)     = NULL,
       @i_feceta            datetime        = NULL,
       @i_banco             int             = NULL,
       @i_oficina           int             = NULL,
       @i_modo              int             = NULL,
       @i_descripcion       varchar(64)     = NULL,
       @i_banc_corresp      int             = NULL,
       @i_valor             varchar(64)     = NULL,   
       @i_ofic_corresp      int             = NULL,
       @i_ctabanco          varchar(64)     = NULL,
	   @i_cuenta            varchar(24)     = NULL,
       @o_existe_comext     char(1)         = NULL OUT,
       @o_existe_relacion_sba_cex smallint  = NULL OUT,
       @o_estcex            char(1)         = NULL OUT,
       @o_opecex            varchar(24)     = NULL OUT,
       @o_of_continente     varchar(7)      = NULL OUT,
       @o_of_pais           int             = NULL OUT,   
       @o_of_ciudad         int             = NULL OUT,
       @o_pa_descripcion    varchar(64)     = NULL OUT,
       @o_ci_descripcion    varchar(64)     = NULL OUT,
       @o_ciudad_bco        varchar(40)     = NULL OUT,
       @o_pais_bco          varchar(40)     = NULL OUT,
	   @o_control           int             = NULL OUT
) 
with encryption   
as

declare @w_error           int,
        @w_mensaje         varchar(255),
        @w_producto        int,
        @w_return          int,
        @w_sp_name         varchar(24)

select @w_sp_name = 'sp_icomext'

/* VALIDACION EXISTENCIA DEL PRODUCTO DE AHORROS */
select @w_producto = COUNT(1) 
from cobis..cl_producto 
where pd_producto = 9
  and pd_estado   = 'V'

if @w_producto = 0
begin
   /* MAPEO DE VARIBALES */
   select @o_existe_comext           = 'N'
   select @o_existe_relacion_sba_cex = 0
   select @o_estcex                  = ''
   select @o_opecex                  = ''
   select @o_of_continente           = null
   select @o_of_pais                 = 0   
   select @o_of_ciudad               = 0
   select @o_pa_descripcion          = null
   select @o_ci_descripcion          = null
   select @o_ciudad_bco              = null
   select @o_pais_bco                = null
   select @o_control                 = 1
 
end

/* LA LECTURA DE LA INFORMACION DE COBIS SE HABILITARA DEPENDIENDO DE LA NECESIDAD */
/*
if @w_producto > 0 
begin 
   
   select @o_existe_comext = 'S'

   if @i_operacion = 'A'
   begin
      
      exec @w_return = cob_comext..sp_apertura_tre_sba
            @s_ssn          = @s_ssn,
            @s_rol          = @s_rol,
            @s_user         = @s_user,
            @s_ofi          = @s_ofi,
            @s_date         = @s_date,
            @s_srv          = @s_srv,
            @s_org          = @s_org,
            @s_term         = @s_term,
            @s_sesn         = @s_sesn,
            @s_lsrv         = @s_lsrv,
            @s_ssn_branch   = @s_ssn_branch,
            @t_trn          = @t_trn,
            @i_operacion    = @i_tipo,
            @i_tope         = @i_tope,
            @i_concep       = @i_tope,                -- Transferencias enviadas Plazo Fijo
            @i_opesba       = @i_opesba,              -- Numero de la operacion en plazo fijo
            @i_secsba       = @i_secsba,              -- Secuencia del movimeinto monetario
            @i_modulo       = @i_modulo,
            @i_catego       = @i_catego,
            @i_oforig       = @s_ofi,
            @i_notifi       = @i_notifi,          -- Motivo de la transferencia
            @i_fechem       = @i_fechem,          -- Fecha de creacion
            @i_fechac       = @i_fechac,
            @i_ordena       = @i_ordena,          -- Ordenante
            @i_nomord       = @i_nomord,          -- Nombre del ordenante
            @i_porcde       = @i_porcde,          -- Nombre del ordenante
            @i_dirpcd       = @i_dirpcd,          -- Direccion del ordenante
            @i_dirord       = @i_dirord,          -- Direccion del ordenante
            @i_cedruc       = @i_cedruc,          -- Identificacion del ordenante
            @i_import       = @i_import,          -- Valor de la transferencia
            @i_moneda       = @i_moneda,          -- Moneda de la transferenca
            @i_benefi       = @i_benefi,          -- Nombre del Beneficiario
            @i_dirben       = @i_dirben,          -- Direccion del beneficiario
            @i_ref_opc      = @i_ref_opc,         -- Numero de cuenta del beneficiario
            @i_conben       = @i_conben,          -- Continente del beneficiario
            @i_paiben       = @i_paiben,          -- Pais del beneficiario
            @i_ciuben       = @i_ciuben,          -- Ciudad del beneficiario
            @i_bcoben       = @i_bcoben,          -- Codigo del Banco Beneficiario
            @i_ofiben       = @i_ofiben,          -- Codigo de oficina del Banco Beneficiario
            @i_tdirben      = @i_tdirben,         -- Direccion ABA / 'S' Direccion SWIFT del Banco Beneficiario
            @i_instruccion1 = @i_instruccion1,    -- Instruccion de pago
            @i_nomben       = @i_nomben,          -- Nombre del Banco Beneficiario.
            @i_bcoint       = @i_bcoint,          -- Codigo del banco intemediario
            @i_ofiint       = @i_ofiint,          -- Codigo de oficina del banco intemediario
            @i_tdirint      = @i_tdirint,         -- Direccion ABA / 'S' Direccion SWIFT del Banco Intemediario
            @i_nomint       = @i_nomint           -- Nombre del Banco intermediario. (corresponsal)

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion = 'B'
   begin
   
      select @o_existe_relacion_sba_cex = count(1),
             @o_estcex                  = rv_estado,
             @o_opecex                  = rv_banco_cex
      from cob_comext..ce_relacion_sba_cex
      where rv_operacion_sba    = @i_operacionpf
        and rv_secuencial_sba   = @i_tr_cod_transf

      if @@rowcount = 0
      begin
         select @w_error = 141142
         goto ERROR
      end
   end
   
   if @i_operacion = 'C'
   begin
   
      exec @w_return = cob_comext..sp_anulacion_operacion
           @t_trn     = @t_trn,
           @i_opeban  = @i_opeban,
           @i_feceta  = @i_feceta,
           @i_opesba  = @i_opesba,
           @i_secsba  = @i_secsba,
           @s_ssn     = @s_ssn,
           @s_srv     = @s_srv,
           @s_lsrv    = @s_lsrv,
           @s_user    = @s_user,
           @s_sesn    = @s_sesn,
           @s_term    = @s_term,
           @s_date    = @s_date,
           @s_org     = @s_org,
           @s_ofi     = @s_ofi,
           @s_rol     = @s_rol

      if @w_return <> 0
      begin
         select @w_error = @w_return
         goto ERROR
      end
   end
   
   if @i_operacion ='D'
   begin
   
      select @o_of_continente     = of_continente,
             @o_of_pais           = of_pais,
             @o_of_ciudad         = of_ciudad,
             @o_pa_descripcion    = pa_descripcion,
             @o_ci_descripcion    = ci_descripcion
      from cob_comext..ce_oficina
      left outer join cobis..cl_pais on
         ci_pais    = pa_pais
         left outer join cobis..cl_ciudad on
            of_ciudad = ci_ciudad
      where of_banco    = @i_banco
        and of_oficina  = @i_oficina 
		
      if @@rowcount = 0
      begin
         select @w_error = 141143
         goto ERROR	  
      end     
   end   
   
   if @i_operacion = 'E'
   begin
   
      set rowcount 20
      if  @i_modo = 1
	  begin
	     select 'Banco'       = bc_banco,
		        'Descripcion' = bc_descripcion
	     from cob_comext..ce_banco                  -- BRON: 15/07/09 cob_comext..ce_banco
	     where (bc_descripcion > @i_descripcion or @i_descripcion is null)
	       and bc_descripcion like @i_valor
	     order by bc_descripcion
	  end
      else
	  begin
	     select 'Oficina'    = of_oficina,
	            'Nombre'     = of_nombre,
                'Swift'      = of_dir_swift,
                'Continente' = of_continente,
                'Cod.Pais'   = of_pais,
                'Cod.Ciudad' = of_ciudad,
                'Pais'       = pa_descripcion,
                'Ciudad'     = ci_descripcion
	     from  cob_comext..ce_banco
          inner join cob_comext..ce_oficina on
             bc_banco = of_banco 
             inner join cobis..cl_pais on
               of_pais = pa_pais
               left outer join cobis..cl_ciudad on
                 of_pais = ci_pais and 
                 of_ciudad = ci_ciudad
         where bc_banco = @i_banc_corresp 
           and (of_nombre > @i_descripcion or @i_descripcion is null)
           and of_nombre like @i_valor
         order by of_nombre    	
	  end

      set rowcount 0   
   end
   
   if @i_operacion = 'F'
   begin
   
      if @i_modo = 1
      begin
         select 'Banco'       = bc_banco,
                'Descripcion' = bc_descripcion
	     from cob_comext..ce_banco                 -- BRON: 15/07/09 cob_comext..ce_banco
         where bc_banco = @i_banc_corresp

         if @@rowcount = 0 
         begin
            select @w_error = 149093
            goto ERROR
         end
      end
      else
      begin
         select 'Oficina'     = of_oficina,
                'Nombre'      = of_nombre,
                'Swift'       = of_dir_swift,
                'Continente' = of_continente,
                'Cod.Pais'   = of_pais,
                'Cod.Ciudad' = of_ciudad,
                'Pais'       = pa_descripcion,
                'Ciudad'     = ci_descripcion
         from cob_comext..ce_banco
           inner join cob_interfase..icex_ce_oficina on
             bc_banco = of_banco
               inner join cobis..cl_pais on
                 of_pais = pa_pais
                 left outer join cobis..cl_ciudad on
                    of_pais = ci_pais and 
                    of_ciudad = ci_ciudad
         where bc_banco   = @i_banc_corresp
           and of_oficina = @i_ofic_corresp
                
         if @@rowcount = 0 
         begin
            select @w_error = 149093
            goto ERROR
         end
      end	
   end

   if @i_operacion = 'G'
   begin
      select  1,
              convert(varchar(10),bc_banco),
              bc_descripcion
      from    cob_comext..ce_banco,
              cob_comext..ce_cuenta_bancaria
      where   bc_banco  = bn_banco
      order by bc_banco
   end

   if @i_operacion = 'H'
   begin

      select @o_ciudad_bco = convert(varchar(40),ci_descripcion),
             @o_pais_bco   = convert(varchar(40),pa_descripcion) 
      from cob_comext..ce_banco, cob_comext..ce_cuenta_bancaria, cob_comext..ce_oficina,  
           cobis..cl_pais, cobis..cl_ciudad
      where bc_banco   = bn_banco
        and bn_banco   = of_banco
        and bn_oficina = of_oficina
        and of_ciudad  = ci_ciudad
        and of_pais    = pa_pais
        and bn_banco   = @i_banco
        and bn_cuenta  = @i_ctabanco
      order by bc_banco

      if @@rowcount = 0 
      begin
         select @w_error = 149093
         goto ERROR
      end
   end
   
   if @i_operacion = 'I'
   begin
      select @o_control = 1
      from   cob_comext..ce_operacion
      where  op_operacion_banco = @i_cuenta
   end
   
end
*/

return 0

ERROR:

   exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = @w_error
        
   return @w_error
go

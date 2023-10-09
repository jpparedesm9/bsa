use cob_cuentas
go
IF OBJECT_ID('dbo.sp_revocatoria_cheques') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_revocatoria_cheques
    IF OBJECT_ID('dbo.sp_revocatoria_cheques') IS NOT NULL
        PRINT '<<< FAILED DROPPING PROCEDURE dbo.sp_revocatoria_cheques >>>'
    ELSE
        PRINT '<<< DROPPED PROCEDURE dbo.sp_revocatoria_cheques >>>'
END
go
create proc sp_revocatoria_cheques (
        @s_srv                  varchar(30),
        @s_lsrv                 varchar(30),
        @s_ssn                  int,
        @s_rol                  smallint,
        @s_ofi                  smallint,
        @s_date                 datetime,
        @s_org                  char(1) = 'U',
        @s_user                 varchar(30),
        @s_term                 varchar(10),
        @t_debug                char(1) = 'N',
        @t_file                 varchar(14) = null,
        @t_from                 varchar(30) = null,
        @t_trn                  int,
        @i_cta                  varchar(24),
        @i_cau                  varchar(3),
        @i_cla                  char(1),
        @i_nchq                 int,
        @i_valch                money,
        @i_mon                  tinyint,
        @i_factor               smallint,
        @i_fecha                datetime,
        @i_benef                varchar(20),
        @i_flag_on              int = 0,
        @o_oficina              smallint = null out,
        @o_cuenta               int = null out,
        @o_clase_clte           char(1) = null out,    
        @o_prod_banc            tinyint = null out,
        @o_oficial              smallint = null out --ARV DIC/26/00
)
as
declare @w_return       int,
    @w_sp_name      varchar(30),
        @w_revocados            money,
        @w_oficina              smallint,
        @w_filial               tinyint,
    	@w_mensaje      		varchar(240),
    	@w_mon          		tinyint,
    	@w_publi        		tinyint,
    	@w_desc_causa           varchar(64),
    	@w_desc_clase           varchar(64),
    	@w_estado_actual    	char(1),
    	@w_estado_anterior      char(1),
    	@w_causa_np     		char(3),
    	@w_clase_np     		char(1),
    	@w_comision     		money,
    	@w_comi_iva             money,
    	@w_iva                  money,  
    	@w_valor_comi           money,  
    	@w_costpubli        	money,
    	@w_cheque_ini       	int,
    	@w_chequeras        	smallint,
        @w_categoria            char(1),
        @w_tipo_ente            char(1),
        @w_rol_ente             char(1),
        @w_tipo_def             char(1),
        @w_prod_banc            smallint,
        @w_producto             tinyint,
        @w_tipo                 char(1),
        @w_codigo               int,
        @w_personaliza          char(1),
    	@w_valor        		money,
    	@w_valor_cheque     	money,
    	@w_valor_anterior   	money,
    	@w_smv1         		money,
    	@w_cost_ccr     		money,
    	@w_saldo_para_girar 	money,
    	@w_saldo_contable   	money,
    	@w_disponible       	money,
    	@w_prom_disp            money,
    	@w_promedio1        	money,
    	@w_fecha_tope       	datetime,
        @w_fecdia               datetime,
    	@w_clave1       		int,
    	@w_clave2       		int,
    	@w_reentry  			varchar(240),
    	@w_est                  char(1),
    	@w_dias_rev     		smallint,
    	@w_ciudad_matriz        int,
    	@w_dep                  smallint,
    	@w_valida_cuenta        char(1),
    	@w_ctacte               int,
    	@w_sldcont              money,
    	@w_slddisp              money,
    	@w_nombre               varchar(30),
    	@w_val_mon              money,
    	@w_val_ser              money,
    	@w_sus_flag             tinyint,
    	@w_iva_anio             money,
    	@w_baseiva_anio         money,
        @w_oficina_ori          smallint,
    	@w_prot_periodo         int,  
    	@w_clase_clte           char(1),
    	@w_oficial      		smallint, --ARV DIC/26/00
    	@w_usadeci              char(1),
    	@w_numdeciimp       	tinyint,
    	@w_cliente      		int,
    	@w_paquete      		int, --CLE 11042006
    	@o_exento       		char(1),
    	@o_base         		money,
    	@o_porcentaje       	float


/*  Captura nombre de Stored Procedure  */

select  @w_sp_name = 'sp_revocatoria_cheques'
select @i_fecha = @s_date
select @w_fecdia = @s_date

/*  Modo de debug  */


select  @w_revocados     = cc_revocados,
        @w_disponible    = cc_disponible,
        @w_promedio1     = cc_promedio1,
        @w_prom_disp     = cc_prom_disponible,
        @w_categoria     = cc_categoria,
        @w_tipo_ente     = cc_tipocta,
        @w_rol_ente      = cc_rol_ente,
        @w_tipo_def      = cc_tipo_def,
        @w_prod_banc     = cc_prod_banc,
        @w_producto      = cc_producto,
        @w_tipo          = cc_tipo,
        @w_codigo        = cc_default,
        @w_personaliza   = cc_personalizada,
        @w_cheque_ini    = cc_cheque_inicial,
        @w_chequeras     = cc_chequeras,
        @w_mon           = cc_moneda,
        @w_est           = cc_estado,
        @w_ctacte        = cc_ctacte,
        @w_oficina       = cc_oficina,
        @w_filial        = cc_filial,
        @w_clase_clte    = cc_clase_clte,
    	@w_oficial       = cc_oficial,
    	@w_cliente   	 = cc_cliente,
    	@w_paquete       = cc_paquete   --CLE 11042006
from cob_cuentas..cc_ctacte
where cc_cta_banco = @i_cta

select @o_oficina = @w_oficina,
       @o_cuenta = @w_ctacte

/* Determinar si la cuenta debe ser validada */
 
if @w_est = 'G'
  select @w_valida_cuenta = 'N'
else
  begin
    select @w_valida_cuenta = 'S'
    /* Calcular saldo */
    exec  @w_return = cob_cuentas..sp_calcula_saldo
          @t_debug            = @t_debug,
          @t_file             = @t_file,
          @t_from             = @w_sp_name,
          @i_cuenta           = @w_ctacte,
          @i_fecha            = @i_fecha,
          @i_ofi              = @s_ofi,
          @o_saldo_para_girar = @w_saldo_para_girar out,
          @o_saldo_contable   = @w_saldo_contable out
    if @w_return != 0
      return @w_return

    /*
    /* Valida Fondos */
    if @i_valch > @w_saldo_para_girar   /* @w_disponible */
      begin
    exec cobis..sp_cerror 
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 201017 
    return 201017 
      end
    */

  end

/* Encuentra parametro de decimales */
select @w_usadeci = mo_decimales
from cobis..cl_moneda
where mo_moneda = @i_mon

if @w_usadeci = 'S'
begin

   select @w_numdeciimp = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = 'CTE'
      and pa_nemonico = 'DIM'
   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 201196
      return 201196
   end
end
else
        select @w_numdeciimp = 0

exec @w_return = cob_cuentas..sp_valida_cheque
     @t_debug           = @t_debug,
     @t_file            = @t_file,
     @t_from            = @w_sp_name,
     @i_cuenta          = @w_ctacte,
     @i_cta_banco       = @i_cta,
     @i_cheque          = @i_nchq,
     @i_cheque_ini      = @w_cheque_ini,
     @i_chequeras       = @w_chequeras,
     @i_val_cta         = @w_valida_cuenta,
     @i_moneda          = @i_mon,
     @o_estado_actual   = @w_estado_actual out,
     @o_estado_anterior = @w_estado_anterior out,
     @o_causa_np        = @w_causa_np out,
     @o_clase_np        = @w_clase_np out,
     @o_valor           = @w_valor_cheque out

if @w_return <> 0
    return @w_return

/* Validacion de que el cheque de gerencia se encuentre emitido */

if @w_est = 'G' and @w_estado_actual = 'N'
  begin
    exec cobis..sp_cerror 
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num     = 201052 
    return 201052 
  end
/* Valida si el cheque es certificado no puede Revocar */

  if @w_estado_actual = 'C'
  begin
    exec cobis..sp_cerror 
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num     = 201155 
    return 201155 
  end
/* Validacion de los valores para cheques de gerencia y certificados */

if @w_estado_actual = 'G' or @w_estado_actual = 'C'
  begin

    /* Validar que el valor del cheque se el mismo que de la revocatoria */

    if @i_valch != @w_valor_cheque
      begin
    exec cobis..sp_cerror 
             @t_debug   = @t_debug,
             @t_file    = @t_file,
             @t_from    = @w_sp_name,
             @i_num     = 201136 
    return 201136 
      end

  end

/* Validacion de que el cheque no se encuentre anulado */

if @w_estado_actual = 'A'
begin
        select @w_desc_causa = valor from cobis..cl_catalogo
        where  cobis..cl_catalogo.tabla =
            (select cobis..cl_tabla.codigo
             from cobis..cl_tabla
             where tabla = 'cc_causa_np'
             and cobis..cl_catalogo.codigo = @w_causa_np)
        select @w_desc_clase = valor from cobis..cl_catalogo
        where  cobis..cl_catalogo.tabla =
            (select cobis..cl_tabla.codigo
             from cobis..cl_tabla
             where tabla = 'cc_clase_np'
             and cobis..cl_catalogo.codigo = @w_clase_np)
    select @w_mensaje = 'Causa: ' + @w_desc_causa + 
                        ' Clase: ' + @w_desc_clase
    select @w_mensaje = 'Cheque anulado ' + @w_mensaje
        exec cobis..sp_cerror 
        @t_debug    = @t_debug,
            @t_file         = @t_file,
            @t_from         = @w_sp_name,
            @i_num          = 201010, 
            @i_sev          = 1, 
            @i_msg          = @w_mensaje
        return 201010
end

/* Validacion de que el cheque no haya sido pagado */
if @w_estado_actual = 'P'
begin
    /*  Cheque ya ha sido pagado  */
    exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 201011
    return 201011
end
if @w_estado_actual = 'F'
begin
    /*  Cheque con defecto de forma  */
    exec cobis..sp_cerror
        @t_debug= @t_debug,
        @t_file = @t_file,
        @t_from = @w_sp_name,
        @i_num  = 201093
    return 201093
end

/* Determina dias de retencion de los fondos                            */
/* Determina el valor del salario minimo vital para encontrar el valor  */
/* de los costos por publicacion                                        */

/* Determinacion del departamento que emite la  de debito */

select   @w_dep = de_departamento
  from   cobis..cl_departamento
 where   de_filial = 1 
   and   de_oficina = @s_ofi   
   and   de_descripcion like 'CUENTAS CORRIENTES'

/* VERS. COLOMBIA NO CONSIDERA ESTE PARAMETRO
select @w_smv1 = pa_money / 2
  from cobis..cl_parametro
 where pa_nemonico = 'SMV'
   and pa_producto = 'ADM'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201196
   return 201196
end

select @w_cost_ccr = pa_money
  from cobis..cl_parametro
 where pa_nemonico = 'CCR'

if @@rowcount <> 1
begin
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201196
   return 201196
end
*/

begin tran

/* Tipo de Revocatoria Temporal */

if @i_cla = 'T'
begin

        select @w_publi = 0
        select @w_comision = $0
        select @w_valor_comi = $0 

    if @w_estado_actual = 'R' and @i_factor = 1
    begin
         exec cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 201009
         return 201009
    end

        /* Encontrar el codigo de la ciudad de feriados nacionales */

        select @w_ciudad_matriz = pa_int
          from cobis..cl_parametro
         where pa_producto = 'CTE'
           and pa_nemonico = 'CMA'

        if @@rowcount <> 1
        begin
           exec cobis..sp_cerror
                @t_debug     = @t_debug,
                @t_file      = @t_file,
                @t_from      = @w_sp_name,
                @i_num       = 201196
           return 201196
        end

        /* Numero de dias para fecha tope de Revocatorias Temporales */  

    select @w_dias_rev = pa_tinyint
      from cobis..cl_parametro
     where pa_nemonico = 'DRT'
       and pa_producto = 'CTE'

        if @@rowcount <> 1
        begin
           exec cobis..sp_cerror
                @t_debug     = @t_debug,
                @t_file      = @t_file,
                @t_from      = @w_sp_name,
      @i_num       = 201196
           return 201196
        end

        /* Determina el dia de vencimiento de la revocatoria */
        select @w_fecha_tope = min(dl_fecha)
          from cob_cuentas..cc_dias_laborables
         where dl_ciudad = @w_ciudad_matriz
           and dl_num_dias = @w_dias_rev

    if exists (select * from cc_cheque
                    where cq_cuenta = @w_ctacte
                  and cq_cheque = @i_nchq)
    begin 

               select @w_oficina_ori= np_oficina 
                 from cc_cheque
                where cq_cuenta = @w_ctacte
              and cq_cheque = @i_nchq


        update  cob_cuentas..cc_cheque
           set  cq_estado_anterior = @w_estado_actual,
                    cq_estado_actual   = 'R',
                    np_oficina         = @s_ofi,
                np_fecha_tope      = @w_fecha_tope,
                cq_fecha_reg       = @s_date,
                cq_valor       = @i_valch,
                np_causa       = @i_cau,
                np_clase       = @i_cla,
                cq_origen      = 'V',
                np_filial      = @w_filial,
                        np_acreditado      = 'S',
            cq_usuario     = @s_user,
                        cq_hora            = getdate(),
                        ge_oficina_pago    = @w_oficina_ori
         where  cq_cuenta          = @w_ctacte
               and  cq_cheque          = @i_nchq

        if @@rowcount != 1
        begin
                    exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 205003
                    return 205003
            end
    end
    else
          begin
            /* Insercion en tabla de no pagados */
        insert into cob_cuentas..cc_cheque
                (cq_cuenta, cq_cheque, cq_estado_actual,
            cq_estado_anterior, cq_fecha_reg, cq_valor,
            np_causa, np_clase, np_filial, np_oficina, 
            cq_usuario,
            np_fecha_tope, cq_origen, cq_transferido,
            np_acreditado, cq_hora,
            pt_valor_multa, pt_valor_cobrado)
        values  (@w_ctacte, @i_nchq, 'R',
                        'N', @s_date, @i_valch,
            @i_cau, @i_cla, @w_filial, @s_ofi, @s_user,
            @w_fecha_tope, 'V', 'N',
            'S', getdate(),
            @w_comision,@w_valor_comi)

        if @@error != 0
        begin
                    exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 203013
                    return 203013
            end
    end

end

if @i_cla = 'C' or @i_cla = 'P'
begin

    /*VERS. COLOMBIA: NO CONSIDERA DIAS PUBLICACION
        /* Determinar el numero de publicaciones con el valor del cheque */
    if @i_valch < @w_smv1
          begin
            if @i_valch != $0
              begin
                select @w_publi = 0
                select @w_dias_rev = 30
              end
        else
          begin
                select @w_publi = 3
                select @w_dias_rev = 30
              end
          end
    else
    begin
          if @i_valch >= @w_smv1 and @i_valch < @w_smv1 * 4
            begin
              select @w_publi = 1
              select @w_dias_rev = 72
            end
          else
        begin   
              if @i_valch >= @w_smv1 * 4
               begin
                 select @w_publi = 3
                 select @w_dias_rev = 72
               end
        end
    end

        if @i_cau = 'M'
          begin
            select @w_publi = 0
            select @w_dias_rev = 210
          end

        /* Determinar la fecha tope de la revocatoria */

        select @w_fecha_tope = dateadd(dd,@w_dias_rev,@i_fecha)
        while 1 = 1
          begin
            if exists (select * from cobis..cl_dias_feriados
                        where df_ciudad = @w_ciudad_matriz
                          and df_fecha = @w_fecha_tope)
              select @w_fecha_tope = dateadd(dd,1,@w_fecha_tope)
            else
              break
          end
    VERS. COLOMBIA: NO CONSIDERA DIAS PUBLICACION */
  if @w_est != 'G'
  begin
    exec @w_return = cob_remesas..sp_genera_costos
               @t_debug        = @t_debug,
               @t_file         = @t_file,
               @t_from         = @w_sp_name,
               @i_fecha        = @w_fecdia,
               @i_valor        = 1,
               @i_categoria    = @w_categoria,
               @i_tipo_ente    = @w_tipo_ente,
               @i_rol_ente     = @w_rol_ente,
               @i_tipo_def     = @w_tipo_def,
               @i_prod_banc    = @w_prod_banc,
               @i_producto     = @w_producto,
               @i_moneda       = @i_mon,
               @i_tipo         = @w_tipo,
               @i_codigo       = @w_codigo,
               @i_servicio     = 'RVOC',
               @i_rubro        = '12',
               @i_disponible   = @w_disponible,
               @i_contable     = @w_saldo_contable,
               @i_promedio     = @w_promedio1,
               @i_prom_disp    = @w_prom_disp,
               @i_personaliza  = @w_personaliza,
               @i_filial       = @w_filial,
               @i_oficina      = @w_oficina,
           @i_paquete      = @w_paquete, --CLE 11042006        
               @o_valor_total  = @w_comision out

          if @w_return <> 0
             return @w_return

    exec sp_exento_impuestos
        @i_trn      = @t_trn,
            @i_empresa  = 1,
            @i_impuesto = 'V',
--          @i_causal   = null,
            @i_debcred  = 'C',
--          @i_ofiadmin     = @s_ofi,
            @i_oforig_admin = @s_ofi,
            @i_ofdest_admin = @w_oficina,
            @i_ente     = @w_cliente,
            @i_producto = 3,
            @o_exento   = @o_exento  out,
            @o_base     = @o_base out,
            @o_porcentaje   = @o_porcentaje out

    if @o_exento = 'N'
        select @w_iva = @o_porcentaje
    else
        select @w_iva = 0
            
/***
    select @w_iva = pa_float
            from cobis..cl_parametro
           where pa_nemonico = 'PIVA'
             and pa_producto = 'CTE'
***/

          select @w_comi_iva = round(((@w_comision * @w_iva)/100), @w_numdeciimp)
          select @w_valor_comi = @w_comision + @w_comi_iva

          if @w_comision > $0
          begin
--               if @w_est != 'G'
--               begin
                    /* Genera el debito de     */
                    /* la comision por ODNP de cheque   */
                    exec @w_return = cob_cuentas..sp_nota_credito_debito
                         @t_debug       = @t_debug,
                         @t_file        = @t_file,
                         @t_from        = @w_sp_name,
                         @t_trn         = 50,
                         @t_corr        = 'N',
                         @p_lssn        = 0,
                         @p_rssn_corr   = 0,
                         @t_rty         = 'N',
                         @s_ssn         = @s_ssn,
                         @s_ofi         = @s_ofi,
                         @s_rol         = @s_rol,
                         @s_srv         = @s_srv,
                         @s_lsrv        = @s_lsrv,
                         @s_user        = @s_user,
                         @s_term        = @s_term,
                         @s_org         = @s_org,
                         @t_ssn_corr    = 0,
                         @i_sus         = null,
                         @i_cuenta      = @w_ctacte,
                         @i_cta         = @i_cta,
                 --      @i_val         = @w_comision,
                         @i_val         = @w_valor_comi,
                         @i_ind         = 1,
                         @i_ori         = 'V',
                         @i_cau         = '1',
                         @i_dep         = @w_dep,
                         @i_nchq        = @i_nchq,
                         @i_valch       = 0,
                         @i_mon         = @i_mon,
                         @i_factor      = 1,
           @i_fecha       = @i_fecha,
             @i_cob_nal = 'N',
                         @o_sldcont     = @w_sldcont out,
                         @o_slddisp     = @w_slddisp out,
                         @o_nombre      = @w_nombre out,
                         @o_val_mon     = @w_val_mon out,
                         @o_val_ser     = @w_val_ser out,
                         @o_sus_flag    = @w_sus_flag out

                    if @w_return <> 0
                       return @w_return

                    /* Grabar transaccion monetaria */
                    insert into cob_cuentas..cc_notcredeb
                           (secuencial, alterno, tipo_tran, oficina,
                            usuario, terminal, correccion, sec_correccion, 
                    reentry, origen, nodo, fecha, 
                    cta_banco, signo, valor, indicador, 
                    causa, nro_cheque, val_cheque, remoto_ssn, 
                    moneda, sld_contable, sld_disponible, 
                    departamento,
                            oficina_cta, filial, vimpuesto, vcomision,
                            clase_clte, prod_banc, oficial) --ARV DIC/26/00
                    values (@s_ssn, 10, 50, @s_ofi,
                            @s_user, @s_term, 'N', 0, 
                    'N', 'L', @s_srv, @s_date, 
                    @i_cta, 'D', @w_val_mon, 1, 
                    '1', @i_nchq, @w_valor_comi, 0, 
                    @i_mon, @w_sldcont, @w_slddisp, @w_dep,
                            @w_oficina, @w_filial, @w_comi_iva, 
                    @w_valor_comi,
                            @w_clase_clte, @w_prod_banc, @w_oficial)  --ARV DIC/26/00                   

                    if @@error != 0
                    begin
                         exec cobis..sp_cerror
                              @t_debug      = @t_debug,
                              @t_file       = @t_file,
                              @t_from       = @w_sp_name,
                              @i_num        = 203000
                         return 203000
                    end

                    /* Grabar el registro de regularizacion para la */
                    /* correccion de revocatorias                   */
                    insert into cob_cuentas..cc_fecha_valor
                           (fv_transaccion, fv_cuenta, 
                fv_referencia,
                            fv_rubro, fv_costo)
                    values (@t_trn, @w_ctacte, 
                convert(varchar(24),@i_nchq),
                            '12', @w_valor_comi)

                    if @@error != 0
                    begin
                         /* Error en revocatoria de cheques */
                         exec cobis..sp_cerror
                              @t_debug    = @t_debug,
                              @t_file     = @t_file,
                              @t_from     = @w_sp_name,
                              @i_num      = 201139
                         return 201139
                    end         
               end
     
  end
end

update cob_cuentas..cc_his_cheque
   set hc_estado_actual = 'N'
 where hc_cuenta = @w_ctacte
   and hc_cheque = @i_nchq
   and hc_estado_actual = 'L'
   and hc_estado_anterior = 'R'
   and hc_fecha_anulacion = @s_date

if @@rowcount > 1
begin
   /* Error en actualizacion de historico cheques */
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 205030
   return 205030
end

/* Confirmacion de una revocatoria temporal */

if @i_cla = 'C'
begin

    if @w_estado_actual != 'R' and @i_factor = 1
        begin
         /* Cheque no esta revocado */
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 201177 
             return 201177
        end

        /* Verificacion de qu el cheque haya sido Revocado Temporalmente */

        if @w_clase_np != 'T'
        begin
         /* Cheque no es temporalmente revocado */
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 201125 
             return 201125
        end

        /* Determinar el valor del cheque revocado anteriormente */
        
        select @w_valor_anterior = cq_valor,
               @w_oficina_ori    =  np_oficina
          from cob_cuentas..cc_cheque
         where cq_cuenta = @w_ctacte
           and cq_cheque = @i_nchq

        /* Actualizacion de tabla de cheques */

    update cob_cuentas..cc_cheque
       set cq_estado_actual = 'R',
               np_oficina       = @s_ofi,
           np_fecha_tope    = @w_fecha_tope,
           cq_fecha_reg = @i_fecha,
           cq_valor     = @i_valch,
           np_causa     = @i_cau,
           np_clase     = @i_cla,
           cq_origen        = 'V',
           np_filial        = @w_filial,
               np_acreditado    = 'N',
           cq_usuario       = @s_user,
               cq_hora          = getdate(),
           pt_valor_multa   = @w_comision,
               pt_valor_cobrado = @w_valor_comi,
               ge_oficina_pago  =  @w_oficina_ori
     where cq_cuenta = @w_ctacte
           and cq_cheque = @i_nchq

    if @@rowcount != 1
    begin
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 205003
             return 205003
          end

               /* Insercion en la tabla cc_his_cheque */
               insert into cob_cuentas..cc_his_cheque
                    (hc_ssn, hc_cuenta, hc_cheque, hc_estado_actual,
                     hc_estado_anterior, hc_fecha_anulacion, hc_hora,
                     hc_origen, hc_valor,
                     hc_causa, hc_clase, hc_filial, hc_oficina, hc_usuario,
                     hc_fecha_levantamiento, hc_clave)
               values (@s_ssn, @w_ctacte, @i_nchq, 'R',
                     @w_estado_actual, @s_date, getdate(), 'V', @i_valch,
                     @i_cau, @i_cla, @w_filial, @s_ofi, @s_user,
                     null, 0)
               if @@error != 0
               begin
                   /* Error en creacion de registro en cc_his_cheque */
                   exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 203036
                   return 203036
               end

        /* Actualizacion de tabla de cuentas corrientes */

        update cob_cuentas..cc_ctacte
           set cc_fecha_ult_mov = @i_fecha
         where cc_ctacte = @w_ctacte

        if @@rowcount != 1
        begin
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 205001
             return 205001
        end

    if @w_estado_actual != 'G' 
    begin
            select @w_revocados = @w_revocados + @i_factor
    end

    /* Guardar beneficiario si no existe */
       
        if @i_benef != null
       
begin
        if not exists (select * from cob_cuentas..cc_chq_beneficiario
                        where cb_cuenta = @w_ctacte
                          and cb_cheque = @i_nchq)
          begin
        insert into cob_cuentas..cc_chq_beneficiario
               (cb_cuenta, cb_cheque, cb_tipo,
            cb_beneficiario)
            values  (@w_ctacte, @i_nchq, 'R', 
             @i_benef)

        if @@error != 0
          begin
            exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 203018
                return 203018
                end

          end
        end

end

/* Revocatoria Permanente */
if @i_cla = 'P'
begin

    if @w_estado_actual = 'R' and @i_factor = 1
    begin
         exec cobis..sp_cerror
              @t_debug        = @t_debug,
              @t_file         = @t_file,
              @t_from         = @w_sp_name,
              @i_num          = 201009
         return 201009
    end

    if exists (select * from cc_cheque
                    where cq_cuenta = @w_ctacte
                  and cq_cheque = @i_nchq)
    begin 

                select @w_oficina_ori  = np_oficina  
                  from cc_cheque
                 where cq_cuenta = @w_ctacte
               and cq_cheque = @i_nchq


        update  cob_cuentas..cc_cheque
           set  cq_estado_anterior = @w_estado_actual,
                    cq_estado_actual   = 'R',
                    np_oficina         = @s_ofi,
                np_fecha_tope      = @w_fecha_tope,
                cq_fecha_reg       = @s_date,
                cq_valor       = @i_valch,
                np_causa       = @i_cau,
                np_clase       = @i_cla,
                cq_origen      = 'V',
                np_filial      = @w_filial,
                        np_acreditado      = 'N',
            cq_usuario     = @s_user,
                        cq_hora            = getdate(),
                        ge_oficina_pago    = @w_oficina_ori
         where  cq_cuenta          = @w_ctacte
               and  cq_cheque          = @i_nchq

        if @@rowcount != 1
        begin
                    exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 205003
                    return 205003
            end

               /* Insercion en la tabla cc_his_cheque */
               insert into cob_cuentas..cc_his_cheque
                    (hc_ssn, hc_cuenta, hc_cheque, hc_estado_actual,
                     hc_estado_anterior, hc_fecha_anulacion, hc_hora,
                     hc_origen, hc_valor,
                     hc_causa, hc_clase, hc_filial, hc_oficina, hc_usuario,
                     hc_fecha_levantamiento, hc_clave)
               values (@s_ssn, @w_ctacte, @i_nchq, 'R',
                     @w_estado_actual, @s_date, getdate(), 'V', @i_valch,
                     @i_cau, @i_cla, @w_filial, @s_ofi, @s_user,
                     null, 0)
               if @@error != 0
               begin
                   /* Error en creacion de registro en cc_his_cheque */
                   exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 203036
                   return 203036
               end                                                   
    end
    else
    begin
               /* Insercion en la tabla cc_his_cheque */
               insert into cob_cuentas..cc_his_cheque
                    (hc_ssn, hc_cuenta, hc_cheque, hc_estado_actual,
                     hc_estado_anterior, hc_fecha_anulacion, hc_hora,
                     hc_origen, hc_valor,
                     hc_causa, hc_clase, hc_filial, hc_oficina, hc_usuario,
                     hc_fecha_levantamiento, hc_clave)
               values (@s_ssn, @w_ctacte, @i_nchq, 'R',
                     @w_estado_actual, @s_date, getdate(), 'V', @i_valch,
                     @i_cau, @i_cla, @w_filial, @s_ofi, @s_user,
                     null, 0)
               if @@error != 0
               begin
                   /* Error en creacion de registro en cc_his_cheque */
                   exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 203036
                   return 203036
               end                                                   

            /* Insercion en tabla de no pagados */
        insert into cob_cuentas..cc_cheque
                (cq_cuenta, cq_cheque, cq_estado_actual,
            cq_estado_anterior, cq_fecha_reg, cq_valor,
            np_causa, np_clase, np_filial, np_oficina, cq_usuario,
            np_fecha_tope, cq_origen, cq_transferido,
            np_acreditado, cq_hora,
            pt_valor_multa, pt_valor_cobrado)
        values  (@w_ctacte, @i_nchq, 'R',
                    'N', @s_date, @i_valch,
            @i_cau, @i_cla, @w_filial, @s_ofi, @s_user,
            @w_fecha_tope, 'V', 'N',
            'N', getdate(), @w_comision, @w_valor_comi)

        if @@error != 0
        begin
                    exec cobis..sp_cerror
                        @t_debug        = @t_debug,
                        @t_file         = @t_file,
                        @t_from         = @w_sp_name,
                        @i_num          = 203013
                    return 203013
            end
    end

    if @w_estado_actual != 'G' 
    begin
            select @w_revocados = @w_revocados + @i_factor
    end

    /* Guardar beneficiario */

        if @i_benef != null
       
begin
        if not exists (select * from cob_cuentas..cc_chq_beneficiario
                        where cb_cuenta = @w_ctacte
                          and cb_cheque = @i_nchq)
          begin

        insert into cob_cuentas..cc_chq_beneficiario
                (cb_cuenta, cb_cheque, cb_tipo,
                 cb_beneficiario)
            values  (@w_ctacte, @i_nchq, 'R', 
             @i_benef)

        if @@error != 0
          begin
            exec cobis..sp_cerror
                    @t_debug        = @t_debug,
                    @t_file         = @t_file,
                    @t_from         = @w_sp_name,
                    @i_num          = 203018
                return 203018
              end
          end
        end

end

if (@i_cla = 'C' or @i_cla = 'P') and @w_est != 'G'
  begin
        /* Actualizacion de tabla de cuentas corrientes */

        update cob_cuentas..cc_ctacte
           set cc_revocados     = @w_revocados,
               cc_fecha_ult_mov = @i_fecha,
--       cc_prot_periodo_ant = cc_prot_periodo_ant + 1,
         cc_iva_anio = cc_iva_anio + @w_iva,
         cc_baseiva_anio = cc_baseiva_anio + @w_comi_iva
         where @w_ctacte = cc_ctacte

        if @@rowcount != 1
        begin
             exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from         = @w_sp_name,
                  @i_num          = 205001
             return 205001
        end
  end

   /* *** VERSION COLOMBIA: NO SE DEBITA VALOR DEL CHEQUE PARA 
    ORDENES DE NO PAGO INDIVIDUALES  
    if @w_estado_actual != 'C'
      begin
        if @i_valch != $0
          begin
            /* Generar el debito por el valor del cheque */

            exec @w_return = cob_cuentas..sp_nota_credito_debito
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @w_sp_name,
                 @t_trn         = 49,
                 @t_corr        = 'N',
                 @p_lssn        = 0,
                 @p_rssn_corr   = 0,
                 @t_rty         = 'N',
                 @s_ssn         = @s_ssn,
                 @s_ofi         = @s_ofi,
                 @s_rol         = @s_rol,
                 @s_srv         = @s_srv,
                 @s_lsrv        = @s_lsrv,
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_org         = @s_org,
                 @t_ssn_corr    = 0,    
             @i_sus         = null,
                 @i_cuenta      = @w_ctacte,
                 @i_cta         = @i_cta,
                 @i_val         = @i_valch,
                 @i_ind         = 1,
        @i_ori         = 'V',
                 @i_cau         = '36',
                 @i_dep         = @w_dep,
                 @i_nchq        = @i_nchq,
                 @i_valch       = 0,
                 @i_mon         = @i_mon,
                 @i_factor      = 1,
                 @i_fecha       = @i_fecha,
                 @o_sldcont     = @w_sldcont out,
                 @o_slddisp     = @w_slddisp out,
                 @o_nombre      = @w_nombre out,
                 @o_val_mon     = @w_val_mon out,
                 @o_val_ser     = @w_val_ser out,
                 @o_sus_flag    = @w_sus_flag out
                                                   
            if @w_return <> 0
              return @w_return

            /* Grabar transaccion monetaria */
            insert into cob_cuentas..cc_notcredeb
                   (secuencial, tipo_tran, oficina,
                    usuario, terminal, correccion,
                    sec_correccion, reentry, origen,
                    nodo, fecha, cta_banco, signo,
                    valor, indicador, causa, nro_cheque,
                    val_cheque, remoto_ssn, moneda, sld_contable,
                    sld_disponible, departamento,
                    oficina_cta, filial, oficial) --ARV DIC/26/00
            values (@s_ssn, 49, @s_ofi,
                    @s_user, @s_term, 'N',
                    0, 'N', 'L',
                    @s_srv, @i_fecha, @i_cta, 'D',
                    @w_val_mon, 1, '36', @i_nchq,
                    @i_valch, 0, @i_mon, @w_sldcont,
                    @w_slddisp, @w_dep,
                    @w_oficina, @w_filial, @w_oficial)

            if @@error != 0
              begin
                exec cobis..sp_cerror
                     @t_debug   = @t_debug,
                     @t_file    = @t_file,
                     @t_from    = @w_sp_name,
                     @i_num = 203000
                return 203000
              end
          end
      end
   */    

   /* VERSION COLOMBIA: YA SE HACE CALCULO Y DEBITO DE COMISION ANTES
    exec @w_return = cob_remesas..sp_genera_costos
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_fecha        = @w_fecdia,
                @i_valor        = 1,
                @i_categoria    = @w_categoria,
                @i_tipo_ente    = @w_tipo_ente,
                @i_rol_ente     = @w_rol_ente,
                @i_tipo_def     = @w_tipo_def,
                @i_prod_banc    = @w_prod_banc,
                @i_producto     = @w_producto,
                @i_moneda       = @i_mon,
                @i_tipo         = @w_tipo,
                @i_codigo       = @w_codigo,
                @i_servicio     = 'RVOC',
                @i_rubro        = '12',
                @i_disponible   = @w_disponible,
                @i_contable     = @w_saldo_contable,
                @i_promedio     = @w_promedio1,
                @i_prom_disp    = @w_prom_disp,
                @i_personaliza  = @w_personaliza,
                @i_filial       = @w_filial,
                @i_oficina      = @w_oficina,
                @o_valor_total  = @w_comision out

        if @w_return <> 0
              return @w_return

   exec @w_return = cob_remesas..sp_genera_costos
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_fecha        = @w_fecdia,
                @i_valor        = 1,
                @i_categoria    = @w_categoria,
                @i_tipo_ente    = @w_tipo_ente,
                @i_rol_ente     = @w_rol_ente,
                @i_tipo_def     = @w_tipo_def,
                @i_prod_banc    = @w_prod_banc,
                @i_producto     = @w_producto,
                @i_moneda       = @i_mon,
                @i_tipo         = @w_tipo,
                @i_codigo       = @w_codigo,
                @i_servicio     = 'RVOC',
                @i_rubro        = '13',
                @i_disponible   = @w_disponible,
                @i_contable     = @w_saldo_contable,
                @i_promedio     = @w_promedio1,
                @i_prom_disp    = @w_prom_disp,
                @i_personaliza  = @w_personaliza,
                @i_filial       = @w_filial,
                @i_oficina      = @w_oficina,
                @o_valor_total  = @w_costpubli out

        if @w_return <> 0
              return @w_return

        select @w_valor = @w_publi * @w_costpubli 

      if @i_valch = $0
        select  @w_comision = @w_cost_ccr   

          if @w_comision > $0
            begin

        if @w_est != 'G'
        begin
            /* Genera el debito comision por revocatoria de cheque   */
            exec @w_return = cob_cuentas..sp_nota_credito_debito
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @w_sp_name,
                 @t_trn         = 50,
                 @t_corr        = 'N',
                 @p_lssn        = 0,
                 @p_rssn_corr   = 0,
                 @t_rty         = 'N',
                 @s_ssn         = @s_ssn,
                 @s_ofi         = @s_ofi,
                 @s_rol         = @s_rol,
                 @s_srv         = @s_srv,
                 @s_lsrv        = @s_lsrv,
                 @s_user        = @s_user,
                 @s_term        = @s_term,
                 @s_org         = @s_org,
                 @t_ssn_corr    = 0,    
             @i_sus         = null,
                 @i_cuenta      = @w_ctacte,
                 @i_cta         = @i_cta,
                 @i_val         = @w_comision,
                 @i_ind         = 1,
                 @i_ori         = 'V',
                 @i_cau         = '1',
                 @i_dep         = @w_dep,
                 @i_nchq        = @i_nchq,
                 @i_valch       = 0,
                 @i_mon         = @i_mon,
                 @i_factor      = 1,
                 @i_fecha       = @i_fecha,
                 @o_sldcont     = @w_sldcont out,
                 @o_slddisp     = @w_slddisp out,
                 @o_nombre      = @w_nombre out,
                 @o_val_mon     = @w_val_mon out,
                 @o_val_ser     = @w_val_ser out,
                 @o_sus_flag    = @w_sus_flag out
                                                   
            if @w_return <> 0
              return @w_return

            if @w_val_mon <> 0
            begin
               /* Grabar transaccion monetaria */
               insert into cob_cuentas..cc_notcredeb
                      (secuencial, alterno, tipo_tran, oficina,
                       usuario, terminal, correccion,
                       sec_correccion, reentry, origen,
                       nodo, fecha, cta_banco, signo,
                       valor, indicador, causa, nro_cheque,
                       val_cheque, remoto_ssn, moneda, sld_contable,
                       sld_disponible, departamento,
                       oficina_cta, filial, oficial) --ARV DIC/26/00
               values (@s_ssn, 10, 50, @s_ofi,
                       @s_user, @s_term, 'N',
                       0, 'N', 'L',
                       @s_srv, @s_date, @i_cta, 'D',
                       @w_val_mon, 1, '1', @i_nchq,
                       @i_valch, 0, @i_mon, @w_sldcont,
                       @w_slddisp, @w_dep,
                       @w_oficina, @w_filial, @w_oficial)

               if @@error != 0
               begin
                   exec cobis..sp_cerror
                        @t_debug    = @t_debug,
                        @t_file = @t_file,
                        @t_from = @w_sp_name,
                        @i_num  = 203000
                   return 203000
               end
            end
          end

         /* Grabar el registro de regularizacion para la */
                /* correccion de revocatorias                   */       
                insert into cob_cuentas..cc_fecha_valor
                       (fv_transaccion, fv_cuenta, fv_referencia,
                        fv_rubro, fv_costo)
                values (@t_trn, @w_ctacte, convert(varchar(24), @i_nchq),
                        '12', @w_comision)

                if @@error != 0
                  begin
                    /* Error en revocatoria de cheques */
                    exec cobis..sp_cerror
                         @t_debug    = @t_debug,
                         @t_file     = @t_file,
                         @t_from     = @w_sp_name,
                         @i_num      = 201139
                    return 201139
                  end

            end

          if @w_valor > 0
          begin
             if @w_est != 'G'
             begin
            /* Genera el debito de        */
                /* la publicacion por revocatoria de cheque   */
                exec @w_return = cob_cuentas..sp_nota_credito_debito
                     @t_debug       = @t_debug,
                     @t_file        = @t_file,
                     @t_from        = @w_sp_name,
                     @t_trn         = 50,
                     @t_corr        = 'N',
                     @p_lssn        = 0,
                     @p_rssn_corr   = 0,
                     @t_rty         = 'N',
                     @s_ssn         = @s_ssn,
                     @s_ofi         = @s_ofi,
                     @s_rol         = @s_rol,
                     @s_srv         = @s_srv,
                     @s_lsrv        = @s_lsrv,
                     @s_user        = @s_user,
                     @s_term        = @s_term,
                     @s_org         = @s_org,
                     @t_ssn_corr    = 0,    
                 @i_sus         = null,
                     @i_cuenta      = @w_ctacte,
                     @i_cta         = @i_cta,
                     @i_val         = @w_valor,
                     @i_ind         = 1,
                     @i_ori         = 'V',
                     @i_cau         = '32',
                     @i_dep         = @w_dep,
                     @i_nchq        = @i_nchq,
                     @i_valch       = 0,
                     @i_mon         = @i_mon,
                     @i_factor      = 1,
                     @i_fecha       = @i_fecha,
                     @o_sldcont     = @w_sldcont out,
                     @o_slddisp     = @w_slddisp out,
                     @o_nombre      = @w_nombre out,
                     @o_val_mon     = @w_val_mon out,
                     @o_val_ser     = @w_val_ser out,
                     @o_sus_flag    = @w_sus_flag out

                if @w_return <> 0
                   return @w_return

                if @w_val_mon <> 0
                begin
                   /* Grabar transaccion monetaria */
                   insert into cob_cuentas..cc_notcredeb
                      (secuencial, alterno, tipo_tran, oficina,
                       usuario, terminal, correccion,
                       sec_correccion, reentry, origen,
                       nodo, fecha, cta_banco, signo,
                       valor, indicador, causa, nro_cheque,
                       val_cheque, remoto_ssn, moneda, sld_contable,
                       sld_disponible, departamento,
                       oficina_cta, filial, oficial)  --ARV DIC/26/00
                   values (@s_ssn, 20, 50, @s_ofi,
                       @s_user, @s_term, 'N',
                       0, 'N', 'L',
                       @s_srv, @s_date, @i_cta, 'D',
                       @w_val_mon, 1, '32', @i_nchq,
                       @i_valch, 0, @i_mon, @w_sldcont,
                       @w_slddisp, @w_dep,
                       @w_oficina, @w_filial, @w_oficial)

  if @@error != 0
                   begin
                      exec cobis..sp_cerror
                           @t_debug = @t_debug,
                           @t_file  = @t_file,
                           @t_from  = @w_sp_name,
                           @i_num   = 203000
                      return 203000
                   end
                end
         end

             /* Grabar el registro de regularizacion para la */
             /* correccion de revocatorias                   */       
             insert into cob_cuentas..cc_fecha_valor
                    (fv_transaccion, fv_cuenta, fv_referencia,
                     fv_rubro, fv_costo)
             values (@t_trn, @w_ctacte, convert(varchar(24), @i_nchq),
                     '13', @w_valor)

             if @@error != 0
             begin
                    /* Error en revocatoria de cheques */
                    exec cobis..sp_cerror
                         @t_debug    = @t_debug,
                         @t_file     = @t_file,
                         @t_from     = @w_sp_name,
                         @i_num      = 201139
                    return 201139
             end
          end
  end

   */

select @o_clase_clte = @w_clase_clte 
select @o_prod_banc = @w_prod_banc 
select @o_oficial   = @w_oficial
commit tran 
return 0
go
IF OBJECT_ID('dbo.sp_revocatoria_cheques') IS NOT NULL
    PRINT '<<< CREATED PROCEDURE dbo.sp_revocatoria_cheques >>>'
ELSE
    PRINT '<<< FAILED CREATING PROCEDURE dbo.sp_revocatoria_cheques >>>'
go
SET ANSI_NULLS OFF
go
SET QUOTED_IDENTIFIER OFF
go

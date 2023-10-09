/************************************************************************/
/*      Archivo:                cu_incga.sp                             */
/*      Stored procedure:       sp_crear_contragarantias                */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               Garantias                               */
/*      Disenado por:           Iván Jiménez                            */
/*      Fecha de escritura:     19/Sep/2006                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes  exclusivos  para el  Ecuador  de la   */
/*      "NCR CORPORATION".                                              */
/*      Su  uso no autorizado  queda expresamente  prohibido asi como   */
/*      cualquier   alteracion  o  agregado  hecho por  alguno de sus   */
/*      usuarios   sin el debido  consentimiento  por  escrito  de la   */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*       Permite crear las contragarantias para cuentas corrientes      */
/*       y tarjetas de crédito en Batc.                                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*         FECHA              AUTOR                  RAZON              */
/*      19/Sep/2006        Iván Jiménez          Emision Inicial        */
/************************************************************************/
use cob_custodia 
go

if exists (select 1 from sysobjects where name = 'sp_crear_contragarantias')
   drop proc sp_crear_contragarantias
go


create proc sp_crear_contragarantias(
   @s_ssn                  int          = null,
   @s_date                 datetime     = null,
   @s_user                 login        = null,
   @s_term                 varchar(64)  = null,
   @s_corr                 char(1)      = null,
   @s_ssn_corr             int          = null,
   @s_ofi                  smallint     = null,
   @s_srv                  varchar(30)  = null,
   @s_lsrv                 varchar(30)  = null,
   @t_rty                  char(1)      = null,
   @t_from                 varchar(30)  = null,
   @t_trn                  smallint     = null,
   @i_operacion            char(1),
   @i_producto             int,
   @i_fecha                datetime
)
as
declare
   @w_sp_name        varchar(60),
   @w_return         int,
   @w_cuenta         varchar(30),
   @w_documento      varchar(64),
   @w_sesion         int,
   @w_sesion1        int,
   @w_longitud       int,
   @w_cont           int,
   @w_asc            smallint,
   @w_cliente        int,
   @w_banca          catalogo,
   @w_nombre         varchar(254),
   @w_ofl            smallint,
   @w_descdir_ec     char(120),
   @w_oficina        smallint,
   @w_telefono       char(12),
   @w_tipo_cust      varchar(30),
   @w_item2          tinyint,  
   @w_item3          tinyint, 
   @w_codigo_ext     varchar(64),   
   @w_ciudad         int,
   @w_porcen         float,
   @w_clase          char(1),
   @w_ofi_conta      smallint,
   @w_existe         int

select  @w_sp_name = 'sp_crear_contragarantias'


if @i_operacion = 'I'
begin
    if @i_producto = 3
    begin
       select @w_sesion = 0
    
       declare cur_cuenta cursor for
       select  cc_cuenta, cc_documento
       from    cob_custodia..cu_carga_contgar3
       where   cc_cuenta > ''
       for read only
    
       open cur_cuenta
       fetch cur_cuenta into @w_cuenta, @w_documento
    
       while @@fetch_status = 0
       begin
          if @@fetch_status != -1
          begin
             --VALIDAR SI LA CUENTA ES NUMERICA
             select @w_longitud = IsNull(DATALENGTH(@w_cuenta),1),
                    @w_cont     = 1,
                    @w_sesion   = @w_sesion + 1
    
             while @w_cont <= @w_longitud
             begin
                select @w_asc = ASCII(SUBSTRING(@w_cuenta,@w_cont,1))
    
                if @w_asc < 48 or @w_asc > 57
                begin
                   insert into cu_ecarcontrag
                     (ec_fecha,   ec_cuenta,   ec_producto, ec_error)
                   Values
                     (@i_fecha,   @w_cuenta,   @i_producto, 'El numero de cuenta no valido')
    
                   goto SIGUIENTE
                End
                select @w_cont = @w_cont + 1
             End
    
             --VALIDAR SI LA CUENTA NO ESTA CERRADA
    
             /*if exists (select 1
                     from  cob_cuentas..cc_ctacte
                     where cc_cta_banco = @w_cuenta
                     and   cc_estado    = 'C')*/
             exec cob_interfase..sp_crear_contragarantias_interfase
                 @i_cuenta        = @w_cuenta,
                 @o_existe        = @w_existe
             if exists (select @w_existe)
             begin
                insert into cu_ecarcontrag
                  (ec_fecha,   ec_cuenta,   ec_producto, ec_error)
                Values
                  (@i_fecha,   @w_cuenta,   @i_producto, 'La cuenta se encuentra cerrada')
    
                goto SIGUIENTE
             End
    
            --VALIDAR QUE EL CLIENTE SEA NO OFICIAL
            /*select  @w_cliente    = cc_cliente,
                    @w_banca      = en_banca,
                    @w_nombre     = en_nomlar,
                    @w_ofl        = en_oficial,
                    @w_descdir_ec = cc_descripcion_ec,
                    @w_oficina    = cc_oficina,
                    @w_telefono   = cc_telefono
            from cob_cuentas..cc_ctacte, cobis..cl_ente
            Where en_ente    = cc_cliente
            and cc_cta_banco = @w_cuenta*/
            exec cob_interfase..sp_crear_contragarantias_interfase
                @i_cuenta        =  @w_cuenta,
                @o_cliente       =  @w_cliente out,
                @o_banca         =  @w_banca out,    
                @o_nombre        =  @w_nombre out,    
                @o_ofl           =  @w_ofl out,      
                @o_descdir_ec    =  @w_descdir_ec out,
                @o_oficina       =  @w_oficina out,  
                @o_telefono      =  @w_telefono out 
    
            if @w_banca = '1'  --OFICIAL
            begin
                insert into cu_ecarcontrag
                  (ec_fecha,   ec_cuenta,   ec_producto, ec_error)
                Values
                  (@i_fecha,   @w_cuenta,   @i_producto, 'El cliente es un ente oficial')
    
                goto SIGUIENTE
            End
    
            --CREACION DE LA GARANTIA
    
    
            select @w_tipo_cust = pa_char
            from  cobis..cl_parametro
            where pa_producto = 'GAR'
            and   pa_nemonico = 'COGCTE'
    
            select @w_item2      = 2,
                   @w_item3      = 3,
                   @w_codigo_ext = null
    
            select @w_codigo_ext = ic_codigo_externo
            from  cob_custodia..cu_item_custodia
            where ic_tipo_cust  = @w_tipo_cust
            and   ic_item       = @w_item2
            and   ic_valor_item = @w_cuenta
    
    
            select @w_ciudad = of_ciudad
            from  cobis..cl_oficina
            where of_oficina = @w_oficina
    
    
             select @w_porcen = tc_porcen_cobertura,
                    @w_clase  = tc_clase
             from  cob_custodia..cu_tipo_custodia
             where tc_tipo = @w_tipo_cust
    
    
    
            if @w_codigo_ext is null
            begin
               exec @w_return = cob_custodia..sp_custodia
                  @s_ssn                  = @w_sesion,
                  @s_date                 = @i_fecha,
                  @s_user                 = 'crebatch',
                  @s_term                 = 'operador',
                  @s_ofi                  = @w_oficina,
                  @s_srv                  = 'operador',
                  @s_lsrv                 = 'operador',
                  @t_rty                  = 'operador',
                  @t_trn                  = 19090,
                  @i_operacion            = 'I',
                  @i_filial               = 1,
                  @i_sucursal             = @w_oficina,
                  @i_tipo                 = @w_tipo_cust,
                  @i_estado               = 'P',
                  @i_fecha_ingreso        = @i_fecha,
                  @i_valor_inicial        = 1,
                  @i_valor_actual         = 1,
                  @i_moneda               = 0,
                  @i_garante              = @w_cliente,
                  @i_nomcliente           = @w_nombre,
                  @i_oficial              = @w_ofl,
                  @i_instruccion          = @w_documento,
                  @i_direccion_prenda     = @w_descdir_ec,
                  @i_ciudad_prenda        = @w_ciudad,
                  @i_telefono_prenda      = @w_telefono,
                  @i_cuantia              = 'I',
                  @i_compartida           = 'N',
                  @i_provisiona           = 'N',
                  @i_origen               = 'CTE',
                  @i_oficina              = @w_oficina,
                  @i_oficina_contabiliza  = @w_oficina,
                  @i_propuesta            = 0,
                  @i_clase_custodia       = @w_clase,
                  @i_fuente_valor         = 'VRDOCU',
                  @i_motivo_noinsp        = '99',
                  @i_ubicacion            = '5',
                  @i_porcentaje_cobertura = @w_porcen,
                  @i_agotada              = 'N',
                  @i_abierta_cerrada      = 'C',
                  @i_siniestro            = 'N',
                  @i_cuenta               = @w_cuenta,
                  @i_carta_instruccion    = 'S'

               if @w_return != 0
               begin
                insert into cu_ecarcontrag
                  (ec_fecha,   ec_cuenta,   ec_producto, ec_error)
                Values
                  (@i_fecha,   @w_cuenta,   @i_producto, 'Error en insercion de garantia')
               
                goto SIGUIENTE
               End
            End
            Else
            Begin
               update cob_custodia..cu_item_custodia
               set ic_valor_item = @w_documento
               where ic_tipo_cust      = @w_tipo_cust
               and   ic_item           = @w_item3
               and   ic_codigo_externo = @w_codigo_ext

               goto SIGUIENTE
            End
             
            SIGUIENTE:
            fetch cur_cuenta into @w_cuenta, @w_documento
    
         end  --cur_cuenta @@fetch_status != -1
       end  --cur_cuenta @@fetch_status = 0

       Close cur_cuenta
       deallocate cur_cuenta

    end  --@i_producto = 3
    
    if @i_producto = 4
    begin
       select @w_ofi_conta = pa_smallint
       from  cobis..cl_parametro
       where pa_producto = 'GAR'
       and   pa_nemonico = 'OCTCR'
    
       select @w_sesion1 = 0

       declare cur_cta_tar cursor for
       select  cc_cuenta, cc_documento
       from    cob_custodia..cu_carga_contgar58
       where   cc_cuenta > ''
       for read only
    
       open cur_cta_tar
       fetch cur_cta_tar into @w_cuenta, @w_documento
    
       while @@fetch_status = 0
       begin
          if @@fetch_status != -1
          begin
             --VALIDAR SI LA CUENTA ES NUMERICA
             select @w_longitud = IsNull(DATALENGTH(@w_cuenta),1),
                    @w_cont     = 1,
                    @w_sesion1   = @w_sesion1 + 1
    
             while @w_cont <= @w_longitud
             begin
                select @w_asc = ASCII(SUBSTRING(@w_cuenta,@w_cont,1))
    
                if @w_asc < 48 or @w_asc > 57
                begin
                   insert into cu_ecarcontrag
                     (ec_fecha,   ec_cuenta,   ec_producto, ec_error, ec_tipo)
                   Values
                     (@i_fecha,   @w_cuenta,   @i_producto, 'El numero de tarjeta no valido', 'I')
    
                   goto SIGUIENTE1
                End
                select @w_cont = @w_cont + 1
             End
    
             --VALIDAR SI LA TARJETA NO ESTA CANCELADA
             if exists (select 1
                        from  cob_credito..cr_dato_operacion
                        where do_tipo_reg               = 'D'
                        and   do_codigo_producto        = 58
                        and   do_numero_operacion_banco = @w_cuenta
                        and   do_estado_contable        = 4)
             begin
                insert into cu_ecarcontrag
                  (ec_fecha,   ec_cuenta,   ec_producto, ec_error)
                Values
                  (@i_fecha,   @w_cuenta,   @i_producto, 'La tarjeta esta cancelada')
                goto SIGUIENTE1
             End
    
    
             select @w_oficina = do_oficina,
                    @w_cliente = do_codigo_cliente,
                    @w_nombre  = en_nomlar,
                    @w_ofl     = en_oficial
             from  cob_credito..cr_dato_operacion, cobis..cl_ente
             where do_tipo_reg               = 'D'
             and   do_codigo_producto        = 58
             and   do_numero_operacion_banco = @w_cuenta
             and   do_codigo_cliente         = en_ente
    
            --CREACION DE LA GARANTIA
            select @w_tipo_cust = pa_char
            from  cobis..cl_parametro
            where pa_producto = 'GAR'
            and   pa_nemonico = 'COGTCR'
    
            select @w_item2      = 2,
                   @w_item3      = 3,
                   @w_codigo_ext = null
    
            select @w_codigo_ext = ic_codigo_externo
            from  cob_custodia..cu_item_custodia
            where ic_tipo_cust  = @w_tipo_cust
            and   ic_item       = @w_item3
            and   ic_valor_item = @w_cuenta
    
            select @w_ciudad = of_ciudad
            from  cobis..cl_oficina
            where of_oficina = @w_oficina
    
            select @w_porcen = tc_porcen_cobertura,
                   @w_clase  = tc_clase
            from cob_custodia..cu_tipo_custodia
            where tc_tipo = @w_tipo_cust
    
            if @w_codigo_ext is null
            begin
               exec @w_return = cob_custodia..sp_custodia
                  @s_ssn                  = @w_sesion1,
                  @s_date                 = @i_fecha,
                  @s_user                 = 'crebatch',
                  @s_term                 = 'operador',
                  @s_ofi                  = @w_oficina,
                  @s_srv                  = 'operador',
                  @s_lsrv                 = 'operador',
                  @t_rty                  = 'operador',
                  @t_trn                  = 19090,
                  @i_operacion            = 'I',
                  @i_filial               = 1,
                  @i_sucursal             = @w_oficina,
                  @i_tipo                 = @w_tipo_cust,
                  @i_estado               = 'P',
                  @i_fecha_ingreso        = @i_fecha,
                  @i_valor_inicial        = 1,
                  @i_valor_actual         = 1,
                  @i_moneda               = 0,
                  @i_garante              = @w_cliente,
                  @i_nomcliente           = @w_nombre,
                  @i_oficial              = @w_ofl,
                  @i_instruccion          = @w_documento,
                  @i_cuantia              = 'I',
                  @i_compartida           = 'N',
                  @i_provisiona           = 'N',
                  @i_origen               = 'TCR',
                  @i_oficina              = @w_oficina,
                  @i_oficina_contabiliza  = @w_ofi_conta,
                  @i_propuesta            = 0,
                  @i_clase_custodia       = @w_clase,
                  @i_fuente_valor         = 'VRDOCU',
                  @i_motivo_noinsp        = '99',
                  @i_ubicacion            = '5',
                  @i_porcentaje_cobertura = @w_porcen,
                  @i_agotada              = 'N',
                  @i_abierta_cerrada      = 'C',
                  @i_siniestro            = 'N',
                  @i_cuenta               = @w_cuenta,
                  @i_carta_instruccion    = 'S'
     
               if @w_return != 0
               begin
                  insert into cu_ecarcontrag
                     (ec_fecha,   ec_cuenta,   ec_producto, ec_error, ec_tipo)
                  values
                     (@i_fecha,   @w_cuenta,   @i_producto, 'Error en insercion de garantia','I')
    
                  goto SIGUIENTE1
               end
            End
            Else
            Begin
               update cob_custodia..cu_item_custodia
               set ic_valor_item = @w_documento
               where ic_tipo_cust = @w_tipo_cust
               and ic_item = @w_item2
               and ic_codigo_externo = @w_codigo_ext
    
               goto SIGUIENTE1
            End
            
            SIGUIENTE1:
            fetch cur_cta_tar into @w_cuenta, @w_documento
          end -- cur_cta_tar @@fetch_status != -1
       end -- cur_cta_tar @@fetch_status = 0
    
       Close cur_cta_tar
       deallocate cur_cta_tar
    
    end --@i_producto = 4

end --@i_operacion = 'I'
go
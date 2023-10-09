/****************************************************************/
/* ARCHIVO:         b_subtip.sp                                 */
/* NOMBRE LOGICO:   sp_bus_subtipos                             */
/* PRODUCTO:        SERVICIOS BANCARIOS                         */
/****************************************************************/
/*                         IMPORTANTE                           */
/* Esta aplicacion es parte de los paquetes bancarios propiedad */
/* de MACOSA S.A.                                               */
/* Su uso no  autorizado queda  expresamente prohibido asi como */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus */
/* usuarios sin el debido consentimiento por escrito de MACOSA. */
/* Este programa esta protegido por la ley de derechos de autor */
/* y por las  convenciones  internacionales de  propiedad inte- */
/* lectual.  Su uso no  autorizado dara  derecho a  MACOSA para */
/* obtener  ordenes de  secuestro o retencion y  para perseguir */
/* penalmente a los autores de cualquier infraccion.            */
/****************************************************************/
/*                          PROPOSITO                           */
/* Este stored procedure permite buscar los datos relacionados  */
/* con los subtipos de instrumentos definidos para el modulo.   */
/****************************************************************/
/*                      MODIFICACIONES                          */
/* FECHA         AUTOR            RAZON                         */
/* 22/oct/98     S.Garces         Emision Inicial               */
/****************************************************************/
use cob_sbancarios
go

if exists (select 1 from sysobjects where name = 'sp_bus_subtipos')
    drop proc sp_bus_subtipos
go

create proc sp_bus_subtipos
(
    @t_debug            char(1)     = 'N',
    @t_file             varchar(14) = null,
    @t_trn              smallint    = null,
    @s_ofi              smallint    = null,
    @i_modo             char(1)     = null,
    @i_cod_subtipo      int         = 0,
    @i_estado           char(1)     = null,
    @i_cod_prod         tinyint     = null,
    @i_cod_ins          smallint    = null,
    @i_valor_unitario   money       = null,
    @i_comercial        char(1)     = 'N',
    @i_oficina          smallint    = null,
    @i_secuencial       int         = 0,
    @i_bco              smallint    = null,
    @i_cuenta           varchar(15) = null
)
as

/* Declaracion de variables de uso Interno */ 
declare @w_return   int,        /* valor retorno SPs */
        @w_sp_name  varchar(32) /* nombre del stored procedure*/

/* Asignar el nombre del stored procedure */
select  @w_sp_name = 'sp_bus_subtipos'

/* Verificacion de tipo de transaccion */
if @t_trn <> 29265
begin
    /* 'Tipo de transaccion no corresponde' */
    exec cobis..sp_cerror
        @t_debug  = @t_debug,
        @t_file   = @t_file,
        @t_from   = @w_sp_name,
        @i_num    = 2902500
    return 1
end

/* buscar todos los subtipos */
if @i_modo = 'S'
begin
    /* numero de registros que se envian al FE */
    set rowcount 40
    select 40

    /* buscar subtipos diponibles */
    select  'COD.'        = si_cod_subtipo, 
            'DESCRIPCION' = si_nombre, 
            'ESTADO'      = si_estado,
            'PROD.'       = si_cod_producto, 
            'INST.'       = si_cod_instrumento, 
            'V.UNIT.'     = si_valor_unitario,
            'NEG.'        = si_negociable,
            'NUM.AUT.'    = si_num_automatica,
            'TIPO CALC.'  = si_forma_calc,
            'BENEF.'      = si_beneficiario,
            'CC'          = si_enlace_cc,
            'BANC ASOC.'  = si_datos_cheque,
            'PARAM OFI.'  = si_param_oficina
    from  sb_subtipos_ins
    where si_cod_subtipo     > @i_cod_subtipo
    and  (si_cod_producto    = @i_cod_prod or @i_cod_prod is null)
    and  (si_cod_instrumento = @i_cod_ins  or @i_cod_ins  is null)
    and  (si_estado          = @i_estado   or @i_estado   is null)

    if @@rowcount = 0
    begin
        /* 'No se encuentran registros con parametros especificados '*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 2902502
        return 1
    end
end

/* buscar subtipo especifico */
if @i_modo = 'H'
begin
    /* buscar detalle del registro */
    select  'COD. SUBT.'  = si_cod_subtipo, 
            'DESCRIPCION' = si_nombre, 
            'ESTADO'      = si_estado,
            'PROD.'       = si_cod_producto, 
            'INST.'       = si_cod_instrumento, 
            'V.UNIT.'     = si_valor_unitario,
            'NEG.'        = si_negociable,
            'NUM.AUT.'    = si_num_automatica,
            'CALC.'       = si_forma_calc,
            'BENEF.'      = si_beneficiario,
            'MONEDA'      = in_moneda,
            'COTIZ.'      = in_tipo_cotizacion,
            'CC'          = si_enlace_cc,
            'BANC ASOC.'  = si_datos_cheque
    from sb_subtipos_ins, sb_instrumentos
    where si_cod_subtipo   = @i_cod_subtipo
    and in_cod_instrumento = si_cod_instrumento

    if @@rowcount = 0
    begin
        /* 'No se encuentra detalle del subtipo de instrumento especificado '*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 2902544
        return 1
    end
end

/* buscar subtipo especifico que esté parametrizado por oficina*/
if @i_modo = 'O'
begin
    if @i_oficina is null
       select @i_oficina = @s_ofi
       
    /* buscar detalle del registro */
    select  'COD. SUBT.'  = si_cod_subtipo, 
            'DESCRIPCION' = si_nombre, 
            'ESTADO'      = si_estado,
            'PROD.'       = si_cod_producto, 
            'INST.'       = si_cod_instrumento, 
            'V.UNIT.'     = si_valor_unitario,
            'NEG.'        = si_negociable,
            'NUM.AUT.'    = si_num_automatica,
            'CALC.'       = si_forma_calc,
            'BENEF.'      = si_beneficiario,
            'MONEDA'      = in_moneda,
            'COTIZ.'      = in_tipo_cotizacion,
            'CC'          = si_enlace_cc,
            'BANC ASOC.'  = si_datos_cheque
    from sb_subtipos_ins, sb_instrumentos
    where in_cod_instrumento = si_cod_instrumento
    and si_cod_subtipo   = @i_cod_subtipo

    and (  (si_param_oficina = 'N')
        or
           (    si_param_oficina = 'S'
            and si_cod_subtipo in
                ( select so_cod_subtipo
                  from sb_subtipos_oficina
                  where so_oficina = @i_oficina 
                )
          )  
        )  


    if @@rowcount = 0
    begin
        /* 'No se encuentra detalle del subtipo de instrumento especificado '*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 2903184
        return 1
    end
end

/* buscar subtipo especifico que esté parametrizado por oficina para F5*/
if @i_modo = 'C'
begin
   set rowcount 20
   select 20

   if @i_comercial = 'N'
   begin
       if @i_oficina is null
          select @i_oficina = @s_ofi
          
      /* buscar detalle del registro */
      select  'COD. SUBT.'  = si_cod_subtipo, 
              'DESCRIPCION' = si_nombre
      from  sb_subtipos_ins
      where si_estado = 'A'
      and  si_cod_instrumento = @i_cod_ins
      and  (   (si_param_oficina = 'N')
            or ( si_param_oficina = 'S' 
                 and si_cod_subtipo in
                  ( select so_cod_subtipo
                    from   sb_subtipos_oficina
                    where  so_oficina = @i_oficina
                  )
               )
           ) 
      and   si_cod_subtipo     > @i_cod_subtipo
              
      if @@rowcount = 0
      begin
          /* 'No se encuentra detalle del subtipo de instrumento especificado '*/
          exec cobis..sp_cerror
              @t_debug    = @t_debug,
              @t_file     = @t_file,
              @t_from     = @w_sp_name,
              @i_num      = 2903184
          return 1
      end
   end
   else
   begin
      if @i_oficina is null
      begin
         select
         Cuenta = pcc_cuenta,
         Banco  = (select ba_descripcion from cob_remesas..re_banco where ba_banco = x.pcc_banco),
         Sec    = pcc_secuencial
         from   sb_ctas_comercl x
         where  pcc_secuencial > @i_secuencial
         and    (pcc_banco     = @i_bco    or @i_bco is null)
         and    (pcc_cuenta    = @i_cuenta or @i_cuenta is null)
         order  by pcc_secuencial
      end
      else
      begin
         if @i_cod_ins is null -- Cuentas para consignacion en bancos
         begin
            select
            CodBco    = pcc_banco,
            Banco     = (select ba_descripcion from cob_remesas..re_banco where ba_banco = x.pcc_banco),
            Cuenta    = pcc_cuenta,
            Nemonico  = pcc_nemonico,
            Sec       = pcc_secuencial
            from   sb_ctas_comercl x
            where  pcc_secuencial > @i_secuencial
            and    (pcc_banco     = @i_bco  or @i_bco is null)
            and    (pcc_cuenta    = @i_cuenta or @i_cuenta is null)
            and    pcc_nemonico   is not null
            order  by pcc_secuencial
            
            if @@rowcount = 0
               print 'NO EXISTEN DATOS CON LAS CONDICIONES SELECCIONADAS'
         end
         else
            select 
            Cuenta  = pcc_cuenta, 
            Banco   = (select ba_descripcion from cob_remesas..re_banco where ba_banco = x.pcc_banco), 
            Subtipo = pcc_subtipo,
            Sec     = pcc_secuencial
            from    sb_ctas_comercl x, sb_subtipos_ins
            where   pcc_subtipo        = si_cod_subtipo
            and     si_cod_instrumento = @i_cod_ins
            and     si_estado          = 'A'
            and     (   (si_param_oficina = 'N')
                    or ( si_param_oficina = 'S' 
                         and si_cod_subtipo in
                          ( select so_cod_subtipo
                            from sb_subtipos_oficina
                            where so_oficina = @i_oficina
                          )
                       )
                    ) 
            and     pcc_secuencial > @i_secuencial
            and    (pcc_banco     = @i_bco  or @i_bco is null)
            and    (pcc_cuenta    = @i_cuenta or @i_cuenta is null)
            order   by pcc_secuencial
      end
   end
end

if @i_modo = 'T'
 begin
     set rowcount 20
     
     select
     Cuenta = pcc_cuenta,
     Banco  = (select ba_descripcion from cob_remesas..re_banco where ba_banco = x.pcc_banco),
     Sec    = pcc_secuencial
     from   sb_ctas_comercl x
     where  pcc_secuencial > @i_secuencial
     and    (pcc_banco     = @i_bco    or @i_bco is null)
     and    (pcc_cuenta    = @i_cuenta or @i_cuenta is null)
     order  by pcc_secuencial

     set rowcount 0         
         
 end

return 0
go

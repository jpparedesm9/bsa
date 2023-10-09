/************************************************************************/
/*    Archivo:         reayudac.sp                                      */
/*    Stored procedure:     sp_rem_ayuda                                */
/*    Base de datos:      cob_remesas                                   */
/*    Producto:               Cuentas Corrientes y Ahorros              */
/*    Disenado por:                                                     */
/*    Fecha de escritura:     20/Jun/1995                               */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                PROPOSITO                                             */
/* Este programa procesa la consulta de los tipos de transacciones      */
/* para manejo de historicos, tanto para CTE como para AHO              */
/************************************************************************/
/*                MODIFICACIONES                */
/*    FECHA        AUTOR        RAZON                */
/*    20/Jun/1995    D Villafuerte   Emision Inicial Bco de Prestamos */
/*      17/Ene/1996    D Villafuerte   Control de Calidad (fechas conf) */
/*      24/Ene/2001    E.Pulido        Aumentar el campo ciudad a 4 dig.*/ 
/*    24/Dic/2002    J. Loyo        Manejo de Corresponsales    */
/*    21/Ene/2003    J. Loyo        Aumentar el Cod Oficina a 4 dig    */
/*    11/Feb/2003    J. Loyo        Generar la consulta de remesas    */
/*                    por medio del estado de la carta*/
/*    07/Oct/2004    O. Ligua        Validar Producto Ban habilitado    */
/************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rem_ayuda')
        drop proc sp_rem_ayuda
go

create proc sp_rem_ayuda (
    @t_debug    char(1)    = 'N',
    @t_file        char(1)    =  null,
        @t_trn        smallint,
        @i_tipo         char(1),
        @i_tipoc        char(1)    = null,
        @i_oficina      smallint   = null,
        @i_banco_c      varchar(11) = null, --ERP 24/01/2001 cc00194
        @i_ultimo       int = 0,
    @i_moneda    tinyint = 0 ,
        @i_formato_fecha int = 101
)
as

declare @w_sp_name    varchar(30),
        @w_fecha_hoy  smalldatetime,
        @w_banco_c    tinyint,
        @w_oficina_c  smallint,
        @w_ciudad_c   smallint,
        @w_ciudad     smallint,
    @w_bancochar    char(2),
    @w_banco     smallint,
    @w_oficina_int    int

select @w_sp_name = 'sp_rem_ayuda'

/* Valida Transaccion */
   if @t_trn != 447
      begin
         exec cobis..sp_cerror
           @t_debug     = @t_debug,
           @t_file      = @t_file,
           @t_from      = @w_sp_name,
           @i_num       = 301019 
         return 1
      end

/* Obtine la fecha del sistema */
   select @w_fecha_hoy = convert(varchar(10),fp_fecha,101)
     from cobis..ba_fecha_proceso

/* Parametros Codigo del Banco */
select @w_banco = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CBCO'
   and pa_producto = 'CTE'
if @@rowcount <> 1
begin
    exec cobis..sp_cerror
        @i_num       = 201196
    return 201196
end

select     @w_bancochar = convert (char(2), @w_banco )
     
 
/* Consulta Numeros de Carta permisibles de Confirmar */
   if @i_tipo = 'N'        
      begin

         /* OLI 10072004. Validacion Producto Bancario Habilitado*/
         if exists (select 1 from cobis..cl_pro_moneda
                    where pm_producto = 0    --Canales CTE y AHO
                      and pm_estado   = 'B')
         begin
            /* No puede realizar operaciones hasta Inicio de Dia */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 351030
            return 351030
         end


    select @w_ciudad_c = ci_cod_remesas 
    from 
        cobis..cl_oficina, 
        cobis..cl_ciudad
    where  of_oficina = @i_oficina
    and of_ciudad = ci_ciudad
    
         set rowcount 20
         select 'CARTA' =  @w_bancochar  + 
                         --right(('00' + convert(varchar(3),ct_ciudad_c)),3) +
                         right(('000' + convert(varchar(4),ct_ciudad_c)),4) + --ERP 24/01/2001 cc00194
                         right(('00000000' + convert(varchar(9),ct_carta)),9),
                'FECHA EMIS' = convert(varchar(10),ct_fecha_emi,@i_formato_fecha),   --CMI Y2K
                'FECHA EFEC' = convert(varchar(10),ct_fecha_efe,@i_formato_fecha),    --CMI Y2K
        'PROCESO' = C.valor

         from  cob_remesas..re_carta,
        cobis..cl_tabla T,
        cobis..cl_catalogo C

         where ct_estado    = 'N'
           and ct_carta     > @i_ultimo
       and (   ct_banco_c  = @w_banco and ct_ciudad_c  = @w_ciudad_c 
        or ct_banco_c <> @w_banco and ct_cob       = @i_oficina  )
       and ct_moneda    = @i_moneda
       and T.tabla      = 're_tcliente'
       and T.codigo     = C.tabla
       and C.codigo      = ct_proceso
         order by ct_carta

--         where ct_fecha_efe >= @w_fecha_hoy 
--           and ct_fecha_emi < @w_fecha_hoy
--           and ct_oficina   = @i_oficina 

         if @@rowcount = 0 and @i_ultimo = 0
            begin
               exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 351003
               return 351003
           end     
         set rowcount 0

      end

/* Consulta de Corresponsales */
   if @i_tipo = 'C'    
      begin
     
        select @w_oficina_int = convert(int,substring(@i_banco_c,3,5))
        if @w_oficina_int >= 32767 
        begin
            /*** No existe oficina    ****/
            exec cobis..sp_cerror
                @t_debug        = @t_debug,
                @t_file         = @t_file,
                @t_from         = @w_sp_name,
                @i_num          = 101016
            return 101016
        End


      /* Separa codigo de Corresponsal */
         select @w_banco_c   = convert(tinyint,substring(@i_banco_c,1,2)),
                @w_oficina_c = @w_oficina_int,  -- convert(smallint,substring(@i_banco_c,3,5)),
                --@w_ciudad_c  = convert(smallint,substring(@i_banco_c,6,3))
                @w_ciudad_c  = convert(smallint,substring(@i_banco_c,8,4)) --ERP 24/01/2001 cc00194

      /* Obtiene ciudad de la Oficina de Trabajo */   
         select @w_ciudad = ob_ciudad
         from cob_remesas..re_ofi_banco
         where ob_ofi_cobis = @i_oficina


       if @i_tipoc = 'I'     /* Individual */
         begin

            select 'DESCRIPCION' = ba_descripcion + ' ' + ci_descripcion
            from cob_remesas..re_transito, 
         cob_remesas..re_bcocedente,
                 cob_remesas..re_banco,
                 cobis..cl_ciudad
            where tn_nombre    = @w_ciudad
          and tn_banco_p   = @w_banco_c
          and tn_oficina_p = @w_oficina_c
          and tn_banco_p   = bc_banco
          and bc_estado = 'V'
          and bc_banco = ba_banco
          and tn_ciudad_p = ci_cod_remesas

--              and tn_oficina_c = @w_oficina_c 
--              and tn_ciudad_c  = @w_ciudad_c  
--              and tn_banco_c   = @w_banco_c
--              and tn_banco_c   = ba_banco
--              and tn_ciudad_c  = ci_cod_remesas

             if @@rowcount = 0
                begin
                   exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 351041
                   return 351041
                end     

         end
  
       else
      
          begin              /* Todos los Corresponsales */
          
             set rowcount 20

--             select distinct
--                'Banco' = substring (right(('00' + convert(varchar(3),tn_banco_c)),2)
--                + right(('00' + convert(varchar(3),tn_oficina_c)),3)
                --+ right(('00' + convert(varchar(3),tn_ciudad_c)),3),1,15),
--                + right(('000' + convert(varchar(4),tn_ciudad_c)),4),1,15), --ERP 24/01/2001 cc00194
--                'Nombre' = substring (ba_descripcion + ' ' + ci_descripcion,1,35)
--             from cob_remesas..re_transito,
--                  cob_remesas..re_banco,
--                  cobis..cl_ciudad
--             where tn_nombre      = @w_ciudad
--               and tn_banco_c     = ba_banco 
--               and tn_ciudad_c    = ci_cod_remesas
--               and tn_banco_c     > @i_ultimo
--             order by tn_banco_c
    select 
                'Banco' = substring (right(('00' + convert(varchar(3),ba_banco)),2)
                + right(('0000' + convert(varchar(5),tn_oficina_p)),5)
                + right(('000' + convert(varchar(4),ci_cod_remesas)),4),1,15),

                'Nombre' = substring (ba_descripcion + ' ' + ci_descripcion,1,35)

      from cob_remesas..re_transito,
        cob_remesas..re_bcocedente,
        cob_remesas..re_banco,
        cobis..cl_ciudad
     where tn_nombre = @w_ciudad
       and tn_banco_p = bc_banco 
       and bc_estado = 'V'
       and bc_banco = ba_banco
       and tn_ciudad_p = ci_cod_remesas
       and tn_banco_p > @i_ultimo


             if @@rowcount = 0
                begin
                   exec cobis..sp_cerror
                     @t_debug        = @t_debug,
                     @t_file         = @t_file,
                     @t_from         = @w_sp_name,
                     @i_num          = 351041
                   return 351041
                end     
             set rowcount 0
          
          end

end

return 0
 
go

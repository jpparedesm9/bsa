/************************************************************************/
/*  Archivo:        cseqcomp.sp             */
/*  Stored procedure:   sp_cseqcomp             */
/*  Base de datos:      cob_conta               */
/*  Producto:       Administrador               */
/*  Disenado por:       Mauricio Bayas/Sandra Ortiz     */
/*  Fecha de documentacion: 17/Nov/93               */
/************************************************************************/
/*              IMPORTANTE              */
/*  Este programa es parte de los paquetes bancarios propiedad de   */
/*  "MACOSA", representantes exclusivos para el Ecuador de la   */
/*  "NCR CORPORATION".                      */
/*  Su uso no autorizado queda expresamente prohibido asi como  */
/*  cualquier alteracion o agregado hecho por alguno de sus     */
/*  usuarios sin el debido consentimiento por escrito de la     */
/*  Presidencia Ejecutiva de MACOSA o su representante.     */
/*              PROPOSITO               */
/*      Retornar un nuevo secuencial para la tabla pasada como          */
/*      parametro.                                                      */
/*      Notas: las tablas se inicializan con secuencial cero            */
/*             mensaje de error si secuencial llega a 2147483647        */
/*              MODIFICACIONES              */
/*  FECHA       AUTOR       RAZON               */
/*      17/Nov/93       R. Minga V.     Documentacion                   */
/*  04/May/94   F.Espinosa  Parametros tipo "S"     */
/*  11/Ene/01   M.E.Segura  Modo 3 (consecutivo mensual)    */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cseqcomp')
    drop proc sp_cseqcomp
go

create proc sp_cseqcomp (
    @s_ssn          int         = NULL,
    @s_user         login       = NULL,
    @s_sesn         int         = NULL,
    @s_term         varchar(30) = NULL,
    @s_date         datetime    = NULL,
    @s_srv          varchar(30) = NULL,
    @s_lsrv         varchar(30) = NULL,
    @s_rol          smallint    = NULL,
    @s_ofi          smallint    = NULL,
    @s_org_err      char(1)     = NULL,
    @s_error        int         = NULL,
    @s_sev          tinyint     = NULL,
    @s_msg          descripcion = NULL,
    @s_org          char(1)     = NULL,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @i_tabla        varchar(30) = null,
    @i_empresa      tinyint,
    @i_fecha        datetime,
    @i_modulo       tinyint,
    @i_modo         tinyint     = null,
    @i_oficina      smallint    = null,
    @i_numcomprob   int         = 0,
    @i_externo      char(1)     = 'N',
    @o_siguiente    int         =null out)
as
declare @w_return       int,
    @w_fecha    datetime,
    @w_sp_name      varchar(30),
    @w_error        int,
    @w_rowcount     int

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cseqcomp'

if @i_externo = 'S' begin tran

/* si no existe el secuencial para la tabla dada, error */
if @i_modo = 1 --Secuencial por empresa
begin
        if exists (select sc_actual
                from cob_conta..cb_seqnos_comprobante
                where sc_empresa = @i_empresa
                and   sc_fecha >= "01/01/1900"
                and   sc_tabla   = @i_tabla
                and   sc_modulo  = @i_modulo)
        begin
                /* retornar el nuevo secuencial */
            select @o_siguiente = sc_actual + 1
            from cob_conta..cb_seqnos_comprobante
            where sc_empresa = @i_empresa
            and   sc_fecha  >= "01/01/1900"
            and   sc_tabla   = @i_tabla
            and   sc_modulo  = @i_modulo

                /* mensaje si secuencial llega al limite */
                if @o_siguiente = 2147483647
                print 'Secuencial llego al limite'

                /* sumar uno al secuencial de la tabla */
            update cb_seqnos_comprobante
            set sc_actual = @o_siguiente
            where sc_empresa = @i_empresa
            and   sc_fecha  >= "01/01/1900"
            and   sc_tabla   = @i_tabla
            and   sc_modulo  = @i_modulo
            if @@error != 0 /* si no se puede realizar la modificacion, error */
            begin
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 105001
                        return 1
            end

            if @t_debug = 'S'
            begin
                    exec cobis..sp_begin_debug @t_file = @t_file
                    select o_siguiente = @o_siguiente
                    exec cobis..sp_end_debug
            end
            end
        else
        begin
                insert into cb_seqnos_comprobante(sc_empresa,
                   sc_fecha,sc_tabla,sc_modulo,sc_actual)
                values (@i_empresa,@i_fecha,@i_tabla,@i_modulo,1)
                select @o_siguiente = 1
        end
end
else
if @i_modo = 2 --Secuencial por empresa y mensual
    begin
        /* obtener la fecha del primer dia del mes de causación*/
        select @w_fecha = convert(char(2),datepart(mm,@i_fecha))+"/01/"+convert(char(4),datepart(yy,@i_fecha))
        if exists ( select sc_actual
             from cob_conta..cb_seqnos_comprobante
             where sc_empresa = @i_empresa and
                   sc_fecha   = @w_fecha and
                   sc_tabla   = @i_tabla and
                   sc_modulo = @i_modulo)
        begin
                /* retornar el nuevo secuencial */
            select @o_siguiente = sc_actual + 1
            from cob_conta..cb_seqnos_comprobante
            where sc_empresa = @i_empresa
            and sc_fecha   = @w_fecha
            and sc_tabla   = @i_tabla
            and sc_modulo  = @i_modulo

                /* mensaje si secuencial llega al limite */
                if @o_siguiente = 2147483647
                print 'Secuencial llego al limite'

                /* sumar uno al secuencial de la tabla */
            update cb_seqnos_comprobante
            set sc_actual = @o_siguiente
            where sc_empresa = @i_empresa
            and sc_fecha   = @w_fecha
            and sc_tabla   = @i_tabla
            and sc_modulo  = @i_modulo

                /* si no se puede realizar la modificacion, error */
            if @@error != 0
            begin
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 105001
                    return 1
            end

            if @t_debug = 'S'
            begin
                    exec cobis..sp_begin_debug @t_file = @t_file
                    select o_siguiente = @o_siguiente
                    exec cobis..sp_end_debug
            end
            end
        else
        begin
                insert into cb_seqnos_comprobante(sc_empresa,
                    sc_fecha,sc_tabla,sc_modulo,sc_actual)
                    values (@i_empresa,@w_fecha,@i_tabla,@i_modulo, 1)
                select @o_siguiente = 1
        end
    end
else
if @i_modo = 3 --Secuencial por Oficina y anual
begin
        /* obtener la fecha del primer dia del anio de causación*/
        select @w_fecha = "01/"+"01/"+convert(char(4),datepart(yy,@i_fecha))
        if exists ( select sc_actual
             from cob_conta..cb_seqnos_comprobante
             where sc_empresa = @i_empresa and
                   sc_fecha   = @w_fecha and
                   sc_tabla   = @i_tabla and
                   sc_modulo = @i_modulo and
                   sc_oficina = @i_oficina)
        begin
                /* retornar el nuevo secuencial */
            select @o_siguiente = sc_actual + 1
            from cob_conta..cb_seqnos_comprobante
            where sc_empresa = @i_empresa
            and sc_fecha   = @w_fecha
            and sc_tabla   = @i_tabla
            and sc_modulo  = @i_modulo
            and sc_oficina = @i_oficina

                /* mensaje si secuencial llega al limite */
                if @o_siguiente = 2147483647
                print 'Secuencial llego al limite'

                /* sumar uno al secuencial de la tabla */
            update cb_seqnos_comprobante
            set sc_actual = @o_siguiente
            where sc_empresa = @i_empresa
            and sc_fecha   = @w_fecha
            and sc_tabla   = @i_tabla
            and sc_modulo  = @i_modulo
            and sc_oficina = @i_oficina

                /* si no se puede realizar la modificacion, error */
            if @@error != 0
            begin
                    exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 105001
                    return 1
            end

            if @t_debug = 'S'
            begin
                    exec cobis..sp_begin_debug @t_file = @t_file
                    select o_siguiente = @o_siguiente
                    exec cobis..sp_end_debug
            end
            end
        else
        begin
                insert into cb_seqnos_comprobante(sc_empresa,
                    sc_fecha,sc_tabla,sc_modulo,sc_actual,sc_oficina)
                    values (@i_empresa,@w_fecha,@i_tabla,@i_modulo,1,@i_oficina)
                select @o_siguiente = 1
        end
end
else
if @i_modo = 4 --Apartar @i_numcomprob secuenciales para un módulo
begin
        if @i_numcomprob = 0
        begin
            select @o_siguiente = 0
            return 1
        end

        if exists ( select sc_actual
             from cob_conta..cb_seqnos_comprobante
             where sc_empresa = @i_empresa and
                   sc_fecha   = @i_fecha and
                   sc_tabla   = @i_tabla and
                   sc_modulo = @i_modulo)
        begin
                /* retornar el nuevo secuencial */
            select @o_siguiente = sc_actual + @i_numcomprob
            from cob_conta..cb_seqnos_comprobante
            where sc_empresa = @i_empresa
            and sc_fecha   = @i_fecha
            and sc_tabla   = @i_tabla
            and sc_modulo  = @i_modulo

                /* mensaje si secuencial llega al limite */
                if @o_siguiente = 2147483647
                    print 'Secuencial llego al limite'

                /* sumar uno al secuencial de la tabla */
            update cb_seqnos_comprobante
            set sc_actual = @o_siguiente
            where sc_empresa = @i_empresa
            and sc_fecha   = @i_fecha
            and sc_tabla   = @i_tabla
            and sc_modulo  = @i_modulo

                /* si no se puede realizar la modificacion, error */
            if @@error != 0
            begin
                        exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 105001
                        return 1
            end

            select @o_siguiente = (@o_siguiente - @i_numcomprob) + 1

            if @t_debug = 'S'
            begin
                    exec cobis..sp_begin_debug @t_file = @t_file
                    select o_siguiente = @o_siguiente
                    exec cobis..sp_end_debug
            end
            end
        else
        begin
                insert into cb_seqnos_comprobante(sc_empresa,
                    sc_fecha,sc_tabla,sc_modulo,sc_actual)
                    values (@i_empresa,@i_fecha,@i_tabla,@i_modulo, 1)
                select @o_siguiente = 1
        end
        
end else begin   -- Secuencial por empresa y por dia Modo 0

   /* sumar uno al secuencial de la tabla */
   update cb_seqnos_comprobante set 
   @o_siguiente = sc_actual + 1,
   sc_actual    = sc_actual + 1
   where sc_empresa = @i_empresa
   and sc_fecha   = @i_fecha
   and sc_tabla   = @i_tabla
   and sc_modulo  = @i_modulo

   select 
   @w_rowcount = @@rowcount,
   @w_error    = @@error

   if @w_error != 0 begin 
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 601183
      return 1
   end

   if @w_rowcount = 0 begin

      insert into cb_seqnos_comprobante(
      sc_empresa,     sc_fecha,        sc_tabla,
      sc_modulo,      sc_actual)
      values (
      @i_empresa,     @i_fecha,        @i_tabla,
      @i_modulo,      1)
      
      select @o_siguiente = 1

   end

   /* VERIFICAR QUE EL SECUENCIAL SEA BUENO */
   if exists(select 1 from cob_conta_tercero..ct_scomprobante
   where sc_empresa     = @i_empresa
   and   sc_fecha_tran  = @i_fecha
   and   sc_producto    = @i_modulo
   and   sc_comprobante = @o_siguiente)
   begin
   
      select @o_siguiente = max(sc_comprobante) + 1
      from cob_conta_tercero..ct_scomprobante
      where sc_empresa     = @i_empresa
      and   sc_fecha_tran  = @i_fecha
      and   sc_producto    = @i_modulo

      update cb_seqnos_comprobante set 
      sc_actual    = @o_siguiente
      where sc_empresa = @i_empresa
      and sc_fecha   = @i_fecha
      and sc_tabla   = @i_tabla
      and sc_modulo  = @i_modulo
   
      if @@error != 0 begin 
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 601183
         return 1
      end
   
   end
   
   /* mensaje si secuencial llega al limite */
   if @o_siguiente = 2147483647 print 'Secuencial llego al limite'

end

if @i_externo = 'S' commit tran

return 0
go

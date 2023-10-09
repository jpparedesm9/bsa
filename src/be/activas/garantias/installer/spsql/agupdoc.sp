/************************************************************************/
/*  Archivo:            agrupdoc.sp                                     */ 
/*  Stored procedure:       sp_agrupar_documentos                       */ 
/*  Base de datos:      cob_custodia                                    */
/*  Producto:               garantias                                   */
/*  Disenado por:           MVI                                         */
/*  Programado por:     XTA                                             */
/*  Fecha de escritura:     Noviembre 1999                              */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa permite realizar la agrupacion de documentos          */
/*      descontados que pertenezca a un mismo negocio, teniendo como    */
/*      criterios, la moneda, fechas de negocio y montos.               */
/*              MODIFICACIONES                                          */
/*     15/NOV/1999   Xavier Tapia             Emision Inicial           */
/*     28/Nov/2000   Milena Gonzalez          Adicion Fecha importacion */
/*                                            Fecha de Exportacion      */
/************************************************************************/

use cob_custodia
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_agrupar_documentos')
    drop proc sp_agrupar_documentos
go


create proc sp_agrupar_documentos (
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               descripcion = null,
   @s_corr               char(1)     = null,
   @s_ofi                smallint    = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_sucursal           smallint    = null,
   @i_modo               smallint    = null,
   @i_filial             smallint    = null,
   @i_cliente            int         = null,
   @i_proveedor          int         = null,
   @i_negocio            int         = null,
   @i_num_negocio        varchar(64) = null,
   @i_grupo              int         = null,
   @i_valor_actual       money       = null,
   @i_valor_neg          money       = null,
   @i_num_doc            varchar(16) = null,
   @i_fecha_vtoneg       datetime    = null,
   @i_fecha_inineg       datetime    = null,
   @i_ftasa              float       = null,
   @i_tipo_cust          varchar(64) = null,
   @i_dias_neg           int         = null,
   @i_opcion             char(1)     = null,
   @i_tramite            int         = null,
   @i_monto_desde        money       = null,
   @i_monto_hasta        money       = null,
   @i_tipo_doc_sig       varchar(64) = '0',
   @i_proveedor_sig      int         = 0,
   @i_num_doc_sig        varchar(16) = '0',
   @i_moneda             tinyint     = null,
   @i_grupo_sig          int         = 0,
   @i_porcentaje         money       = null,
   @i_responsabilidad    char(1)     = null  --pga 17oct01
 

)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_error              int,
   @w_fecha_vtoneg       datetime,
   @w_grupo              int,
   @w_negocio            int,
   @w_num_negocio        varchar(64),
   @w_compuesto          varchar(64),
   @w_ceros              varchar(10),
   @w_longitud           tinyint,
   @w_sum_valor_neg      money,
   @w_cliente            int,
   @w_moneda             tinyint,
   @w_fecha_dex          datetime,
   @w_fecha_bl           datetime,
   @w_proveedor          int,     --pga 17oct01
   @w_con_respon         char(1) ,
   @w_num_dec            smallint, --emg redondeo
   @w_spid               int

   


select @w_today   = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_agrupar_documentos',
       @w_spid    = @@spid * 100

/***********************************************************/
/* Codigos de Transacciones                                */


if (@t_trn <> 19889 and @i_operacion = 'A') or
   (@t_trn <> 19889 and @i_operacion = 'N') or
   (@t_trn <> 19889 and @i_operacion = 'G') or
   (@t_trn <> 19889 and @i_operacion = 'D') or
   (@t_trn <> 19889 and @i_operacion = 'I') or
   (@t_trn <> 19889 and @i_operacion = 'S') or
   (@t_trn <> 19916 and @i_operacion = 'C') 

begin

/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end



/* VALIDACION DE CAMPOS NULOS */
/******************************/

/*NUMERO DE DECIMALES*/
exec @w_return = cob_cartera..sp_decimales
@i_moneda    = @i_moneda,
@o_decimales = @w_num_dec out

if @w_return <> 0 begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = @w_return
    return 1 
end


delete cu_tmp_documentos
where sesion = @w_spid

if @i_operacion = 'A' 
begin
    if @i_cliente         is NULL or 
       @i_num_negocio     is NULL or
       @i_responsabilidad is NULL 
    begin
        /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end



    insert into cu_tmp_documentos (
    valor,             fecha_vto,       moneda,    fecha_dex,    
    fecha_bl,    proveedor,             sesion)
    select
    sum(do_valor_neg), do_fecha_vtoneg, do_moneda, do_fecha_dex, 
    do_fecha_bl, do_proveedor,          @w_spid
    from  cu_documentos
    where do_proveedor    = @i_cliente
    and   do_grupo        is null --emg dic-5-01
    and   do_num_negocio  = @i_num_negocio
    and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
    and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
    and   (do_moneda      = convert(int,@i_moneda) or @i_moneda is null) --emg Ene-01-01
    group by do_fecha_vtoneg, do_fecha_dex, do_fecha_bl, do_moneda,do_proveedor --emg dic-4-01

    declare cursor_garantia cursor for
    select valor, fecha_vto, moneda, fecha_dex, fecha_bl, proveedor
    from cu_tmp_documentos
    where sesion = @w_spid
    for read only

    open cursor_garantia
    fetch cursor_garantia into
        @w_sum_valor_neg,
        @w_fecha_vtoneg,
        @w_moneda,
        @w_fecha_dex,
        @w_fecha_bl, 
        @w_proveedor --pga 17oct01
        
    while @@fetch_status = 0
    begin  

       /* Por cada registro que tiene la fecha por la que ser n agrupados los
       documentos genero un @w_grupo y actualizo la tabla cu_documentos 
       do_grupo y luego inserto los registros en la cu_grupos doctos */


       select @w_grupo = isnull(max(gd_grupo),0)+1   
       from   cu_grupos_doctos
       where  gd_cliente     = @i_cliente
       and    gd_num_negocio = @i_num_negocio

       begin tran
           if @i_responsabilidad = 'S'   -- con responsabilidad
           begin
               /*si fecha de exportacion/importacion not null*/
               if @w_fecha_dex is null and @w_fecha_bl is null
               begin      
                  insert into cu_grupos_doctos 
                  select distinct
                  @w_grupo,        do_proveedor,    do_num_negocio, @w_sum_valor_neg,
                  do_fecha_vtoneg, do_fecha_inineg, null,           do_moneda,         @i_responsabilidad
                  from  cu_documentos
                  where do_proveedor     = @i_cliente
                  and   do_num_negocio   = @i_num_negocio
                  and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                  and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                  and   do_grupo        is null
                  and   do_fecha_vtoneg  = @w_fecha_vtoneg
                  and   do_moneda        = convert(int,@w_moneda) --emg Ene-15-01
                  if @@error <> 0
                  begin
                      exec cobis..sp_cerror
                      @t_debug = @t_debug,
                      @t_file  = @t_file, 
                      @t_from  = @w_sp_name,
                      @i_num   = 1903001
                      return 1 
                  end
          
                  update  cu_documentos set  
                  do_grupo    = @w_grupo,
                  do_agrupado = 'S'
                  where do_proveedor    = @i_cliente
                  and   do_num_negocio  = @i_num_negocio
                  and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                  and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                  and   do_grupo        is null
                  and   do_fecha_vtoneg = @w_fecha_vtoneg
                  and   do_moneda       = convert(int,@w_moneda) --emg Ene-15-01
                  if @@error <> 0 
                  begin
                      /* Error en insercion de registro */
                      exec cobis..sp_cerror
                      @t_from  = @w_sp_name,
                      @i_num   = 1907001
                      return 1 
                  end
               end
               else
               begin
                     /*si fecha de exportacion e importacion son null*/
                     insert into cu_grupos_doctos 
                     select distinct
                     @w_grupo,         do_proveedor,    do_num_negocio,  @w_sum_valor_neg,
                     do_fecha_vtoneg,  do_fecha_inineg, null,            do_moneda,          @i_responsabilidad
                     from  cu_documentos
                     where do_proveedor    = @i_cliente
                     and   do_num_negocio  = @i_num_negocio
                     and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                     and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                     and   do_grupo        is null
                     and   do_fecha_vtoneg = @w_fecha_vtoneg
                     and   ((do_fecha_bl   = @w_fecha_bl  and do_fecha_dex is null)
                     or    (do_fecha_dex   = @w_fecha_dex and do_fecha_bl  is null))
                     and   do_moneda       = convert(int,@w_moneda)
                     if @@error <> 0
                     begin
                         exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file, 
                         @t_from  = @w_sp_name,
                         @i_num   = 1903001
                         return 1 
                     end
                
                     update  cu_documentos set  
                     do_grupo    = @w_grupo,
                     do_agrupado = 'S'
                     where do_proveedor     = @i_cliente
                     and   do_num_negocio   = @i_num_negocio
                     and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                     and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                     and   do_grupo        is null
                     and   do_fecha_vtoneg =  @w_fecha_vtoneg
                     and   ((do_fecha_bl   =  @w_fecha_bl  and do_fecha_dex is null)
                     or    (do_fecha_dex   =  @w_fecha_dex and do_fecha_bl  is null))
                     and   do_moneda       =  convert(int,@w_moneda)
                     if @@error <> 0
                     begin
                          exec cobis..sp_cerror
                          @t_debug = @t_debug,
                          @t_file  = @t_file, 
                          @t_from  = @w_sp_name,
                          @i_num   = 1905001
                          return 1 
                     end
               end
           end  -- con responsabilidad
          
          
           if @i_responsabilidad = 'N'   -- sin responsabilidad
           begin
                /*si fecha de exportacion/importacion not null*/
                if @w_fecha_dex is null and @w_fecha_bl is null
                begin
                    insert into cu_grupos_doctos 
                    select distinct
                    @w_grupo,        do_proveedor,    do_num_negocio, @w_sum_valor_neg,
                    do_fecha_vtoneg, do_fecha_inineg, null,           do_moneda,        @i_responsabilidad
                    from  cu_documentos
                    where do_proveedor    =  @i_cliente
                    and   do_proveedor    =  @w_proveedor
                    and   do_num_negocio  =  @i_num_negocio
                    and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                    and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                    and   do_grupo        is null
                    and   do_fecha_vtoneg =  @w_fecha_vtoneg
                    and   do_moneda       =  convert(int,@w_moneda) --emg Ene-15-01
                    and   do_proveedor    =  @w_proveedor
                    if @@error <> 0
                    begin
                         exec cobis..sp_cerror
                         @t_debug = @t_debug,
                         @t_file  = @t_file, 
                         @t_from  = @w_sp_name,
                         @i_num   = 1903001
                         return 1 
                    end
          
                    update  cu_documentos set  
                    do_grupo = @w_grupo,
                    do_agrupado = 'S'
                    where do_proveedor    =  @i_cliente
                    and   do_proveedor    =  @w_proveedor
                    and   do_num_negocio  =  @i_num_negocio
                    and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                    and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                    and   do_grupo        is null
                    and   do_fecha_vtoneg =  @w_fecha_vtoneg
                    and   do_moneda       =  convert(int,@w_moneda) --emg Ene-15-01
                    if @@error <> 0
                    begin
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file, 
                        @t_from  = @w_sp_name,
                        @i_num   = 1905001
                        return 1 
                    end
          
                end
                else
                begin
                  /*si fecha de exportacion e importacion son null*/
                    insert into cu_grupos_doctos 
                    select distinct
                    @w_grupo,        do_proveedor,  do_num_negocio,   @w_sum_valor_neg,  do_fecha_vtoneg,
                    do_fecha_inineg, null,          do_moneda,        @i_responsabilidad 
                    from  cu_documentos
                    where do_proveedor     = @i_cliente
                    and   do_proveedor     = @w_proveedor
                    and   do_num_negocio   = @i_num_negocio
                    and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                    and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                    and   do_grupo        is null
                    and   do_fecha_vtoneg  = @w_fecha_vtoneg
                    and   ((do_fecha_bl    = @w_fecha_bl  and do_fecha_dex is null)
                    or    (do_fecha_dex    = @w_fecha_dex and do_fecha_bl  is null))
                    and   do_moneda        = convert(int,@w_moneda)
                    and   do_proveedor     = @w_proveedor
                    if @@error <> 0
                    begin
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file, 
                        @t_from  = @w_sp_name,
                        @i_num   = 1903001
                        return 1 
                    end
          
                    update  cu_documentos set  
                    do_grupo = @w_grupo,
                    do_agrupado = 'S'
                    where do_proveedor     = @i_cliente
                    and   do_proveedor     = @w_proveedor
                    and   do_num_negocio   = @i_num_negocio
                    and   (do_valor_bruto >= @i_monto_desde or @i_monto_desde is null)
                    and   (do_valor_bruto <= @i_monto_hasta or @i_monto_hasta is null)
                    and   do_grupo        is null
                    and   do_fecha_vtoneg  = @w_fecha_vtoneg
                    and   ((do_fecha_bl    = @w_fecha_bl  and do_fecha_dex is null)
                    or    (do_fecha_dex    = @w_fecha_dex and do_fecha_bl  is null))
                    and   do_moneda        = convert(int,@w_moneda)
                    if @@error <> 0
                    begin
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file, 
                        @t_from  = @w_sp_name,
                        @i_num   = 1905001
                        return 1 
                    end
          
                end
           end  -- sin responsabilidad

       commit tran
       fetch cursor_garantia into
       @w_sum_valor_neg,
       @w_fecha_vtoneg,
       @w_moneda,
       @w_fecha_dex,
       @w_fecha_bl,
       @w_proveedor
    end  --while status
    close cursor_garantia
    deallocate cursor_garantia
    
    delete cu_tmp_documentos
    where  sesion = @w_spid
    return 0
end


/*Imprimir*/
if @i_operacion = 'H'
begin
    select
    'TIPO'                 = do_tipo_doc,
    'No.DOCUMENTO'         = do_num_doc,
    'VAL. NEGOCIO'         = do_valor_bruto,
    'PROVEEDOR'            = A.en_nomlar,
    'RESP. PAGO'           = B.en_nomlar,
    'FECHA INICIO NEGOCIO' = convert(varchar(10),do_fecha_inineg,103),
    'FECHA VCTO'           = convert(varchar(10),do_fecha_vtoneg,103),
    'DIAS NEG'             = do_dias_negocio
    -- from  cu_documentos, cobis..cl_ente A, cobis..cl_ente B
    from  cobis..cl_ente A,
      cu_documentos
      RIGHT OUTER JOIN  cobis..cl_ente B
           ON do_resp_pago = B.en_ente
    where do_proveedor   = @i_cliente
    and   do_num_negocio = @i_num_negocio
    and   A.en_ente      = do_proveedor
--  and   B.en_ente      =* do_resp_pago
    order by do_fecha_vtoneg                 

    if @@rowcount = 0
    begin
        select @w_error  = 1901003
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = @w_error
        return 1
    end  

    select sum(do_valor_bruto)
    from   cu_documentos 
    where  do_proveedor   = @i_cliente
    and    do_num_negocio = @i_num_negocio

    return 0
end



if @i_operacion = 'C'
/*Boton ASOCIAR TRAMITE */
begin
    begin tran
        --SBU 06/feb/2002
        select @w_num_negocio = fa_num_negocio
        from   cob_credito..cr_facturas
        where  fa_tramite = @i_tramite
        
        select @w_num_negocio = isnull(@w_num_negocio,' ' )
        
        if (@i_num_negocio <> @w_num_negocio) and (@w_num_negocio <> ' ')
        begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1903017
           return 1 
        end
        
        insert into cob_credito..cr_facturas 
        select 
        @i_tramite,    gd_grupo,        round((do_valor_neg * @i_porcentaje/100), @w_num_dec),
        @i_moneda,     gd_fecha_inineg, gd_fecha_vtoneg,
        'N',           null,            do_num_doc,           @i_porcentaje,      do_num_negocio,  
        do_proveedor,  do_fecha_dex,    do_fecha_bl,          @i_responsabilidad, --PGA11sep2000    
        null,          null,            null
        from  cu_grupos_doctos,cu_documentos
        where gd_cliente     = @i_cliente
        and   gd_num_negocio = @i_num_negocio
        and   gd_tramite    is null
        and   do_proveedor   = @i_cliente
        and   do_num_negocio = @i_num_negocio
        and   do_agrupado   <> 'N'
        and   do_grupo       = gd_grupo
        and   do_moneda      = convert(int,@i_moneda)    --PGA 21sep2000 emg Ene-15-01
        and   gd_num_negocio = do_num_negocio --emg
        --order by gd_fecha_vtoneg
        
        if @@error <> 0
        begin
            /* Registro ya existe */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901002
            return 1 
        end
        
        update cu_grupos_doctos
        set    gd_tramite = @i_tramite
        where  gd_cliente     = @i_cliente
        and    gd_num_negocio = @i_num_negocio
        and    gd_moneda      = @i_moneda  --PGA21sep2000
        and    gd_tramite    is null
        
        if @@error <> 0
        begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1905001
           return 1 
        end
        
        update cob_custodia..cu_documentos
        set    do_estado = 'F'      
        where  do_proveedor   = @i_cliente
        and    do_num_negocio = @i_num_negocio
        if @@error <> 0
        begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1905001
           return 1 
        end

    commit tran 
    return 0
end



if @i_operacion = 'G'
begin
    set rowcount 20
    select 
    'GRUPO'            = do_grupo,
    'TIPO DOCUMENTO'   = convert(varchar(15),do_tipo_doc),
    'NUMERO DOCUMENTO' = do_num_doc,
    'PROVEEDOR'        = do_proveedor,
    'FECHA INI.NEG.'   = convert(char(10),do_fecha_inineg,103),
    'FECHA VCTO.NEG.'  = convert(char(10),do_fecha_vtoneg,103),
    'VALOR NEGOCIO'    = do_valor_neg,
    'NUMERO NEGOCIO'   = convert(varchar(16),do_num_negocio),
    'CLIENTE'          = do_proveedor
    from  cu_documentos
    where do_num_negocio  = @i_num_negocio
    and   do_proveedor    = @i_cliente
    and   do_grupo        = @i_grupo
    and   do_agrupado     = 'S'
    and   ((do_tipo_doc   = @i_tipo_doc_sig  and do_proveedor = @i_proveedor_sig 
    and   do_num_doc      > @i_num_doc_sig)
    or    (do_tipo_doc    = @i_tipo_doc_sig  and do_proveedor > @i_proveedor_sig)
    or    (do_tipo_doc    > @i_tipo_doc_sig)) 
    order by do_tipo_doc,do_proveedor,do_num_doc
    
    if @@rowcount = 0
    begin
       exec cobis..sp_cerror
       @t_from  = @w_sp_name,
       @i_num   = 1901004
       return 1
    end
    
    return 0
end


if @i_operacion = 'D'
begin
   begin tran
       update  cu_documentos set 
       do_grupo    = null,
       do_agrupado = 'N', --PGA21sep200
       do_estado   = 'P'
       where do_proveedor = @i_proveedor
       and   do_num_doc   = @i_num_doc
       if @@error <> 0
       begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1905001
           return 1 
       end
       
      select @w_sum_valor_neg = sum(do_valor_neg)
      from   cu_documentos
      where  do_proveedor   = @i_cliente
      and    do_num_negocio = @i_num_negocio
      and    do_grupo       = @i_grupo

      if @w_sum_valor_neg is null
      begin
         delete cu_grupos_doctos
         where  gd_cliente     = @i_cliente
         and    gd_num_negocio = @i_num_negocio
         and    gd_grupo       = @i_grupo
      end
      else
      begin
         update  cu_grupos_doctos
         set gd_valor_neg = @w_sum_valor_neg
         where gd_cliente = @i_cliente
         and gd_num_negocio = @i_num_negocio
         and gd_grupo = @i_grupo
         if @@error <> 0
         begin
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end
      end
   commit tran
    
   /* Datos para ser mapeados en el Grid de Grupos */
    select 
   'GRUPO'         = gd_grupo,
   'CLIENTE'       = gd_cliente,
   'NUM. NEGOCIO'  = convert(varchar(15),gd_num_negocio),
   'VALOR NEGOCIO' = gd_valor_neg,
   'VTO NEGOCIO'   = convert(varchar(10),gd_fecha_vtoneg,103),
   'INI NEGOCIO'   = convert(varchar(10),gd_fecha_inineg,103)
   from  cu_grupos_doctos
   where gd_cliente     = @i_cliente
   and   gd_num_negocio = @i_num_negocio
   order by gd_grupo
   
   return 0
end



if @i_operacion = 'E'
begin
   begin tran
       update  cu_documentos set 
       do_grupo     = null,
       do_agrupado  = 'N'
       where do_proveedor = @i_cliente
       and   do_num_negocio = @i_num_negocio
       and   do_grupo in (select gd_grupo
                          from   cu_grupos_doctos
                          where  gd_cliente     = @i_cliente
                          and    gd_num_negocio = @i_num_negocio
                          and    gd_tramite    is null)
       if @@error <> 0
       begin
           print 'Error al Desagrupar los Documentos'
           return 1
       end
       
       delete cu_grupos_doctos
       where gd_cliente   = @i_cliente
       and gd_num_negocio = @i_num_negocio
       and gd_tramite    is null
             
       if @@error <> 0
       begin
          print 'Error al Desagrupar los Documentos'
          return 1
       end
   commit tran    
   return 0
end


if @i_operacion = 'I'
begin
    if exists (select 1
              from   cu_grupos_doctos
              where  gd_cliente      = @i_cliente
              and    gd_num_negocio  = @i_num_negocio
              and    gd_fecha_vtoneg = @i_fecha_vtoneg
              and    gd_fecha_inineg = @i_fecha_inineg
              and    gd_moneda       = @i_moneda
              and    gd_tramite      is null)
    begin
         select @w_grupo = gd_grupo
         from cu_grupos_doctos
         where gd_cliente = @i_cliente
         and gd_num_negocio = @i_num_negocio
         and gd_fecha_vtoneg = @i_fecha_vtoneg
         and gd_fecha_inineg = @i_fecha_inineg
         and gd_moneda = @i_moneda
         and gd_tramite is null

         begin tran  
             update  cu_documentos
             set do_grupo = @w_grupo,
             do_agrupado = 'S'
             where do_proveedor = @i_proveedor
             and do_num_doc = @i_num_doc
             if @@error <> 0
             begin
             print 'Error al Aniadir el Documento al grupo'
             return 1
             end

             select @w_sum_valor_neg = sum(do_valor_neg)
             from cu_documentos
             where do_proveedor = @i_cliente
             and do_num_negocio = @i_num_negocio
             and do_grupo  = @w_grupo

             if @w_sum_valor_neg is null
             begin
             print 'No se pudo ingresar el documento'
             return 1
             end

             update  cu_grupos_doctos
             set gd_valor_neg = @w_sum_valor_neg
             where gd_cliente = @i_cliente
             and gd_num_negocio = @i_num_negocio
             and gd_grupo = @w_grupo
          
             if @@error <> 0  
             begin
             print 'Error al Aniadir el Documento'
             return 1
             end      
         commit tran
    end
    else
    begin
         select @w_grupo = isnull(max(gd_grupo),0)+1   
         from   cu_grupos_doctos
         where  gd_cliente     = @i_cliente
         and    gd_num_negocio = @i_num_negocio

         begin tran
            insert into cu_grupos_doctos 
            select distinct
            @w_grupo,        do_proveedor, do_num_negocio, do_valor_neg,      do_fecha_vtoneg,
            do_fecha_inineg, null,         do_moneda,      @i_responsabilidad 
            from  cu_documentos
            where do_proveedor    = @i_cliente
            and   do_num_negocio  = @i_num_negocio
            and   (do_valor_neg  >= @i_monto_desde or @i_monto_desde is null)
            and   (do_valor_neg  <= @i_monto_hasta or @i_monto_hasta is null)
            and   do_grupo       is null
            and   do_fecha_vtoneg = @i_fecha_vtoneg
            and   do_num_doc      = @i_num_doc
         
            update  cu_documentos set 
            do_grupo    = @w_grupo,
            do_agrupado = 'S'
            where do_proveedor = @i_proveedor
            and   do_num_doc   = @i_num_doc
            if @@error <> 0
            begin
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file, 
                @t_from  = @w_sp_name,
                @i_num   = 1905001
                return 1 
            end
         commit tran
    end


    /* Datos para ser mapeados en el Grid de Grupos 
     select 'GRUPO' = gd_grupo,
        'CLIENTE' = gd_cliente,
        'NUM. NEGOCIO' = convert(varchar(15),gd_num_negocio),
        'VALOR NEGOCIO' = gd_valor_neg,
        'VTO NEGOCIO' = convert(varchar(10),gd_fecha_vtoneg,101),
        'INI NEGOCIO' = convert(varchar(10),gd_fecha_inineg,101)
     from cu_grupos_doctos
     where gd_cliente = @i_cliente
       and gd_num_negocio = @i_num_negocio
     order by gd_grupo
    */

    return 0
end


if @i_operacion = 'N'
/*Genera un nuevo numero de negocio para el cliente dado*/
begin
      select @w_negocio = sd_actual+1
      from cu_seqnos_doctos
      where sd_sucursal= @i_sucursal
     
      if @w_negocio is null
      begin
          insert into cu_seqnos_doctos 
          values  (@i_sucursal,1)     
           
          select @w_negocio = 1
      end
      else
      begin
          update cu_seqnos_doctos
          set sd_actual = @w_negocio 
          where sd_sucursal = @i_sucursal
      end
      
      if @i_sucursal < 10
          select @w_num_negocio = '000'+convert(varchar(4),@i_sucursal)
      else
      begin
          if (@i_sucursal >= 10) and (@i_sucursal < 100)
          begin
             select @w_num_negocio = '00'+convert(varchar(4),@i_sucursal)
             if (@i_sucursal >=100) and (@i_sucursal < 1000)
                select @w_num_negocio = '0'+convert(varchar(4),@i_sucursal)
             else
                select @w_num_negocio = convert(varchar(4),@i_sucursal)
          end
      end
      select @w_ceros       = '000000'
      select @w_longitud    = datalength (convert(varchar(6),@w_negocio))
      select @w_num_negocio = @w_num_negocio + substring(@w_ceros,1,6-@w_longitud) 
                                             + convert  (varchar(6), @w_negocio)

      select @w_num_negocio

end

if @i_operacion = 'S'
begin
   /* Datos para ser mapeados en el Grid de Grupos */

   select @w_con_respon = gd_con_respon  
   from   cu_grupos_doctos
   where  gd_cliente     = @i_cliente
   and    gd_num_negocio = @i_num_negocio
   and    gd_grupo       > @i_grupo_sig
   and    gd_tramite     is null
   and    gd_num_negocio = @i_num_negocio

   set rowcount 20  --SBU 06/feb/2002

   select distinct
   'GRUPO'         = gd_grupo,
   'CLIENTE'       = gd_cliente,
   'NUM. NEGOCIO'  = convert(varchar(15),gd_num_negocio),
   'VALOR NEGOCIO' = gd_valor_neg,
   'VTO NEGOCIO'   = convert(varchar(10),gd_fecha_vtoneg,103),
   'INI NEGOCIO'   = convert(varchar(10),gd_fecha_inineg,103),
   'MONEDA'        = do_moneda
   from  cu_grupos_doctos,cu_documentos
   where gd_cliente     = @i_cliente
   and   gd_num_negocio = @i_num_negocio
   and   gd_grupo       > @i_grupo_sig
   and   gd_tramite    is null
   and   do_num_negocio = @i_num_negocio
   and   do_num_negocio = gd_num_negocio
   and   do_proveedor   = gd_cliente
   and   do_grupo       = gd_grupo
   and   (do_moneda     = convert(int,@i_moneda) or @i_moneda is null)
   order by gd_grupo

   set rowcount 0

   select @w_con_respon 

end
return 0
go

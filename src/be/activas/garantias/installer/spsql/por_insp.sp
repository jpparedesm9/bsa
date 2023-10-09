/************************************************************************/
/*      Archivo:                por_insp.sp                             */
/*      Stored procedure:       sp_por_inspeccionar                     */
/*      Base de datos:          cob_custodia                            */
/*      Producto:               garantias                               */
/*      Disenado por:           Rodrigo Garces                          */
/*                              Luis Alfredo Castellanos                */
/*      Fecha de escritura:     Junio-1995                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Ingreso / Modificacion / Eliminacion / Consulta y Busqueda      */
/*      de las Garantias por inspeccionar                               */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA      AUTOR           RAZON                                */
/*      Jun/1995                   Emision Inicial                      */
/*      Dic/2002   JVelandia       reasignacion de Avaluador            */
/************************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_por_inspeccionar')
    drop proc sp_por_inspeccionar
go
create proc sp_por_inspeccionar (
   @s_ssn                int         = null,
   @s_date               datetime    = null,
   @s_user               login       = null,
   @s_term               descripcion = null,
   @s_corr               char(1)     = null,
   @s_ssn_corr           int         = null,
   @s_ofi                smallint    = null,
   @t_rty                char(1)     = null,
   @t_trn                smallint    = null,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)     = null,
   @i_modo               smallint    = null,
   @i_filial             tinyint     = null,
   @i_sucursal           smallint    = null,
   @i_tipo               descripcion = null,
   @i_tipo_cust          descripcion = null,
   @i_custodia           int         = null,
   @i_status             char(1)     = null,
   @i_fecha_ant          datetime    = null,
   @i_inspector_ant      int         = null,
   @i_estado_ant         catalogo    = null,
   @i_inspector_asig     int         = null,
   @i_fecha_asig         datetime    = null,
   @i_formato_fecha      int         = null,
   @i_inspector          int         = null,
   @i_fecha_ini          datetime    = null,
   @i_fecha_insp         datetime    = null,
   @i_fecha_fin          datetime    = null,
   @i_fecha_envio_carta  datetime    = null,
   @i_codigo_externo     varchar(64) = null,
   @i_oficial            int         = null,
   @i_lote               int         = null,
   @i_fecha_max_rep      datetime    = null,   -- FPL Jun/1997 Fecha maxima reporte 
   @i_cond1              char(3)     = null,
   @i_cond2              char(7)     = null,
   @i_cond3              descripcion = null,
   @i_batch              char(1)     = null    -- JAR REQ 266 Paquete 2
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_filial             tinyint,
   @w_sucursal           smallint,
   @w_tipo               varchar(64),
   @w_custodia           int,
   @w_status             char(1),
   @w_inspeccionado      char(1),
   @w_fecha_ant          datetime,
   @w_inspector_ant      int,
   @w_estado_ant         catalogo,
   @w_inspector_asig     int,
   @w_fecha_asig         datetime,
   @w_fecha_inspec       datetime,
   @w_cliente_principal  int,
   @w_riesgos            money, 
   @w_mes_actual         tinyint, 
   @w_nro_inspecciones   tinyint, 
   @w_intervalo          smallint,
   @w_estado             catalogo,
   @w_fecha_insp         datetime,
   @w_scu                descripcion,
   @w_cont               tinyint, /* Flag para saber si existen prendas */
   @w_codigo_externo     varchar(64),
   @w_estado_gar         char(1),
   @w_fecha_prox_insp    datetime,
   @w_oficial            int,
   @w_fecha_ini          datetime,
   @w_fecha_fin          datetime,
   @w_fecha              datetime,
   @w_entecod varchar(10),
   @w_coddir int,
   @w_codente  int,
   @w_lote     tinyint,
   @w_codigo_ext     varchar(64),
   @w_oficina            int      

select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_por_inspeccionar'

if @i_formato_fecha is null
   select @i_formato_fecha = 101
/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19160 and @i_operacion = 'I') or
   (@t_trn <> 19161 and @i_operacion = 'U') or
   (@t_trn <> 19162 and @i_operacion = 'D') or
   (@t_trn <> 19163 and @i_operacion = 'V') or
   (@t_trn <> 19164 and @i_operacion = 'S') or
   (@t_trn <> 19165 and @i_operacion = 'Q') or
   (@t_trn <> 19166 and @i_operacion = 'A') or
   (@t_trn <> 19167 and @i_operacion = 'Z')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A' and @i_batch <> 'S' -- JAR REQ 266
begin

    select 
         @w_filial         = pi_filial,
         @w_sucursal       = pi_sucursal,
         @w_tipo           = pi_tipo,
         @w_custodia       = pi_custodia,
         @w_fecha_ant      = pi_fecha_ant,
         @w_inspector_ant  = pi_inspector_ant,
         @w_estado_ant     = pi_estado_ant,
         @w_inspector_asig = pi_inspector_asig,
         @w_fecha_asig     = pi_fecha_asig,
         @w_codigo_externo = pi_codigo_externo,
         @w_inspeccionado  = pi_inspeccionado,
         @w_fecha_inspec   = pi_fecha_insp
    from cob_custodia..cu_por_inspeccionar
    where pi_filial = @i_filial 
    and   pi_sucursal = @i_sucursal 
    and   pi_tipo   = @i_tipo   
    and   pi_custodia = @i_custodia 
    and   pi_inspeccionado  = 'N'

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
    end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if   @i_filial is NULL or 
         @i_sucursal is NULL or 
         @i_tipo is NULL or 
         @i_custodia is NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end
end

/* Insercion del registro */
/**************************/

if @i_operacion = 'I'
begin
    if @w_existe = 1
    begin
    /* Registro ya existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901002
        return 1 
    end
         -- CODIGO EXTERNO
         exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                         @w_codigo_externo out
    select @w_oficial = cg_oficial
      from cu_cliente_garantia
     where cg_codigo_externo = @w_codigo_externo

    select @w_estado_gar = cu_estado
      from cu_custodia
     where cu_codigo_externo = @w_codigo_externo   
   
    if @w_estado_gar = 'C' --Cancelado
    begin 
    /* No puede inspeccionar garantias canceladas */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905010
        return 1 
    end 
    
    begin tran
       insert into cu_por_inspeccionar(
       pi_filial, pi_sucursal, pi_tipo,
       pi_custodia, pi_fecha_ant, pi_inspector_ant,
       pi_estado_ant, pi_inspector_asig, pi_fecha_asig,
       pi_riesgos, pi_codigo_externo, pi_inspeccionado)
       values (
       @i_filial, @i_sucursal, @i_tipo,
       @i_custodia, @i_fecha_ant, @i_inspector_ant,
       @i_estado_ant, @i_inspector_asig, @s_date,
       isnull(@w_riesgos,0), @w_codigo_externo, 'N')


       if @@error <> 0 
       begin
         /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903001
          return 1 
       end
         

       update cu_custodia
       set cu_fecha_prox_insp = @i_fecha_ini
       where cu_codigo_externo = @w_codigo_externo  
       if @@error <> 0 
       begin
        /* Error en insercion de registro */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1905001
        return 1 
       end



    commit tran 
    return 0
end

/* Actualizacion del registro */
/******************************/

if @i_operacion = 'U'
begin
    if @w_existe = 0
    begin
    /* Registro a actualizar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1905002
        return 1 
    end

    begin tran
         -- CODIGO EXTERNO

       exec sp_externo @i_filial,@i_sucursal,@i_tipo,@i_custodia,
                         @w_codigo_externo out

       update cob_custodia..cu_por_inspeccionar
       set pi_inspector_asig = @i_inspector_asig,
       pi_fecha_asig     = @s_date
       where pi_codigo_externo = @w_codigo_externo
       and pi_inspeccionado  = 'N'
       and pi_fecha_insp     is null 
       if @@error <> 0 
       begin
         /* Error en actualizacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
       end

       select @w_inspector_asig = pi_inspector_asig,
              @w_lote = pi_lote
       from cu_por_inspeccionar
       where pi_codigo_externo = @w_codigo_externo
       and pi_inspeccionado  = 'N'
       and pi_fecha_insp     is null 
      
       /*emg feb-11-02 si se reasigna el inspector*/

       if @w_inspector_asig is not null and @w_lote is not null
       begin
       update cob_custodia..cu_control_inspector
       set ci_inspector = @i_inspector_asig
       where ci_lote = @w_lote
       and ci_inspector = @w_inspector_asig
        
       if @@error <> 0 
       begin
         /* Error en actualizacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1905001
          return 1 
       end
       end


    commit tran
    return 0
end

/* Eliminacion de registros */
/****************************/

if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1907002
        return 1 
    end

/***** Integridad Referencial *****/
/*****                           *****/

    select @w_codigo_ext = cu_codigo_externo
    from   cob_custodia..cu_custodia
    where  cu_sucursal = @i_sucursal
    and    cu_tipo = @i_tipo
    and    cu_custodia = @i_custodia


    begin tran
       delete cob_custodia..cu_por_inspeccionar
       where  pi_filial = @i_filial and
       pi_sucursal = @i_sucursal and
       pi_tipo     = @i_tipo and
       pi_custodia = @i_custodia and
       pi_inspeccionado = 'N'          
       if @@error <> 0
       begin
         /*Error en eliminacion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1907001
         return 1 
       end

       delete cob_custodia..cu_inspeccion
       where  in_codigo_externo = @w_codigo_ext
       if @@error <> 0
       begin
         /*Error en eliminacion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1907001
         return 1 
       end



    commit tran
    return 0
end

/* Consulta opcion QUERY */
/*************************/

if @i_operacion = 'Q'
begin
   if @i_modo = 1                
   begin
      select distinct pi_lote
      from cu_por_inspeccionar
      where pi_fenvio_carta = @i_fecha_envio_carta
      and   pi_filial       = @i_filial
      and   pi_sucursal     = @i_sucursal 
      and   pi_tipo         = @i_tipo_cust 
      return 0
   end 

   if @i_modo = 2
      if @w_existe = 1
         select 
              @w_filial,
              @w_sucursal,
              @w_tipo,
              @w_custodia,
              @w_fecha_ant,
              @w_inspector_ant,
              @w_estado_ant,
              @w_inspector_asig,
              @w_fecha_asig,
              @w_inspeccionado
       else
       begin
       /*Registro no existe */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1901005
          return 1 
      end
   else 

   if @i_modo = 0                
   begin
      select distinct 
      'CARTA ENVIADA'       = convert(varchar(10),pi_fenvio_carta,101),
      ' LOTE No'            = pi_lote
      from cu_por_inspeccionar
      where pi_filial       = convert(tinyint,@i_cond1)
      and   pi_sucursal     = convert(smallint,@i_cond2) 
      and   pi_tipo         = @i_cond3
      and   pi_lote         is not null
      and   pi_fenvio_carta is not null 
    return 0
   end 

   

    return 0
end

/* Operacion de Busqueda con cursor  */

if @i_operacion = 'Z'
begin
   -- INI JAR REQ 266
   create table #garporvisit_tmp (
      GARANTIA         int         null,
      TIPO             descripcion null,
      DESCRIPCION      descripcion null,
      NOMBRE_CLIENTE   varchar(60) null,
      OBLIGACIONES     money       null,
      FECHA_ANT        char(10)    null,
      AVAL_ANT         int         null, 
      NOMBRE_AVAL_ANT  varchar(20) null,
      ESTADO_ANT       catalogo    null,
      CIUDAD           descripcion null,
      AVALUADOR        int         null,
      NOMBRE_AVALUADOR varchar(20) null,
      DETALLE          varchar(20) null,
      OFICINA          int         null,
      DESC_OFICINA     descripcion null)

   select distinct cu_sucursal
     into #oficinas
     from cu_custodia
    where cu_sucursal = isnull(@i_sucursal, cu_sucursal)

   select @w_oficina = 0
   
   while 1=1
   begin   
      select top 1 
             @w_oficina = cu_sucursal
        from #oficinas
       where cu_sucursal > @w_oficina
       order by cu_sucursal
       
      if @@rowcount = 0 break
      
      -- DETERMINAR LAS GARANTIAS A INSPECCIONARSE   
      if @i_batch = 'S'
      begin
         if object_id ('cu_gar_por_visitar') is not null drop table cu_gar_por_visitar
      
         declare busqueda1 cursor for
         select cu_tipo,            cu_custodia,   cu_codigo_externo,   
                cu_intervalo,       cu_fecha_insp, cu_nro_inspecciones, 
                cu_fecha_prox_insp, cu_sucursal        
           from cu_custodia, cu_tipo_custodia, cu_cliente_garantia
          where cu_filial           = @i_filial
            and cu_sucursal         = @w_oficina
            and cu_fecha_prox_insp >= @i_fecha_ini
            and cu_fecha_prox_insp <= @i_fecha_fin
            and cu_garante         is null
            and cu_inspeccionar     = 'S'
            and cu_periodicidad    <> 'N'
            and cu_estado      not in ('A','C')
            and cu_tipo             = tc_tipo
            and tc_contabilizar     = 'S'
            and cu_codigo_externo   = cg_codigo_externo
            and cg_principal        = 'D'
         for read only
        
         if @@error <> 0 return 1903001  
      end  -- if @i_batch = 'S'
      else
      begin
         select @i_custodia = isnull(@i_custodia,0)
         declare busqueda1 cursor for
         select top 20
                cu_tipo,            cu_custodia,   cu_codigo_externo,   
                cu_intervalo,       cu_fecha_insp, cu_nro_inspecciones, 
                cu_fecha_prox_insp, cu_sucursal 
         from cu_custodia,cu_tipo_custodia,cu_cliente_garantia
         where cu_filial           = @i_filial
         and   cu_sucursal         = @w_oficina
         and   (cu_tipo            = @i_tipo_cust or @i_tipo_cust is null)      
         and   cu_garante         is null
         and   cu_custodia         > @i_custodia
         and   cu_inspeccionar     = 'S'    -- A inspeccionar
         and   cu_periodicidad    <> 'N'   -- Periodicidad Ninguna
         and   cu_estado      not in ('A','C')   -- No incluir las canceladas
         and   cu_tipo             = tc_tipo
         and   tc_contabilizar     = 'S'    -- Solo incluir las contabilizables 
         and   cu_codigo_externo   = cg_codigo_externo
         and   cg_principal        = 'D'  --LAL DE S
         and   (cg_oficial         = @i_oficial or @i_oficial is null)
         and   (cu_fecha_prox_insp between  @i_fecha_ini and @i_fecha_fin)
         order by cu_custodia
         for read only
      end  -- else -- if @i_batch = 'S'
      
      open busqueda1
      fetch busqueda1 into 
            @w_tipo,            @w_custodia,   @w_codigo_externo,
            @w_intervalo,       @w_fecha_insp, @w_nro_inspecciones, 
            @w_fecha_prox_insp, @w_sucursal                      
      
      while (@@fetch_status = 0)  -- Lazo de busqueda
      begin
         if exists (select top 1 1 from cu_por_inspeccionar
                     where pi_codigo_externo = @w_codigo_externo
                       and pi_inspeccionado  = 'N')
         begin
            select @w_codigo_externo = @w_codigo_externo -- Ya existe
         end
         else begin
            select
            @w_inspector_ant   = null,
            @w_fecha_ant       = null,
            @w_estado_ant      = null,
            @w_fecha_asig      = null,
            @w_fecha_insp      = null,
            @w_fecha_prox_insp = null
      
            select @w_inspector_ant = in_inspector,
                   @w_fecha_ant     = in_fecha_insp,
                   @w_estado_ant    = in_estado   
            from   cu_inspeccion  -- DATOS DE LA ULTIMA INSPECCION
            where  in_codigo_externo = @w_codigo_externo
            and    in_fecha_insp in (select max(in_fecha_insp) from  cu_inspeccion
                                      where in_codigo_externo = @w_codigo_externo)
            begin tran   
            insert into cu_por_inspeccionar 
            values (@i_filial,      @w_sucursal,      @w_tipo,
                    @w_custodia,    @w_fecha_ant,     @w_inspector_ant,
                    @w_estado_ant,  null,             @w_fecha_prox_insp,
                    null,           @w_codigo_externo,'N',
                    null,           null,             null,
                    null)
            
            if @@error <> 0 
            begin
               close busqueda1
               deallocate busqueda1 
               rollback tran                       
               /* Error en insercion de registro */
               exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 1903001
               return 1                
            end
            commit tran
         end
      
         fetch busqueda1 into
         @w_tipo,            @w_custodia,   @w_codigo_externo,
         @w_intervalo,       @w_fecha_insp, @w_nro_inspecciones,
         @w_fecha_prox_insp, @w_sucursal     
      end   --  FIN DEL WHILE
      
      close busqueda1
      deallocate busqueda1

      insert into #garporvisit_tmp
      select pi_custodia,          pi_tipo,           tc_descripcion, 
             substring(en_nombre , 1, 10 ) + ' ' + substring(p_p_apellido, 1, 10) + ' ' + substring( p_s_apellido, 1, 10),
             pi_riesgos,           convert(char(10),pi_fecha_ant,@i_formato_fecha),
             pi_inspector_ant,     convert(varchar(20),''),
             pi_estado_ant,        ci_descripcion,    pi_inspector_asig, 
             convert(varchar(20),''),                 convert(varchar(20),''),
             pi_sucursal,          (select of_nombre from cobis..cl_oficina
                                     where of_oficina = P.pi_sucursal)   
        from cu_por_inspeccionar P
                inner join cu_cliente_garantia on
                pi_filial                 = @i_filial
                and   pi_sucursal         = @w_oficina
                and   pi_tipo             = isnull(@i_tipo_cust, pi_tipo)
                and   pi_inspeccionado    = 'N'   -- No han sido inspeccionadas
                and   cg_oficial          = isnull(@i_oficial, cg_oficial)
                and   pi_codigo_externo   = cg_codigo_externo 
                and   cg_principal        = 'D'  --LAL DE S   
                   inner join cu_custodia on
                       (cu_fecha_prox_insp between @i_fecha_ini and @i_fecha_fin)
                       and   pi_codigo_externo   = cu_codigo_externo
                       and   cu_periodicidad     <> 'N'   -- Periodicidad Ninguna
                       and   cu_estado       not in ('A','C')   -- No incluir las canceladas                    
                       inner join   cu_tipo_custodia on
                        tc_tipo  = pi_tipo --XTA 10/JUN/1999
                            inner join  cobis..cl_ente on
                               cg_ente = en_ente
                                left outer join cobis..cl_ciudad on
                                   cu_ciudad_prenda = ci_ciudad
                                   where ci_estado  = 'V'                                
   end  -- while 1=1   
   -- FIN JAR REQ 266   
   update #garporvisit_tmp
   set NOMBRE_AVALUADOR = isnull(convert(varchar(20),act.is_nombre),''),
       NOMBRE_AVAL_ANT  = isnull(convert(varchar(20),ant.is_nombre),'')
   from  cu_inspector ant, cu_inspector act
   where AVAL_ANT    = ant.is_inspector
   and   AVALUADOR   = act.is_inspector
         
   if @@error <> 0 
   begin
      if @i_batch = 'S' return 1905001
      else
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
      end
   end   

   update #garporvisit_tmp
   set   DETALLE = isnull(B.valor,'')
   from   cu_inspector
                left outer join cobis..cl_catalogo B  on
                    is_especialidad = B.codigo
                    left outer join  cobis..cl_tabla A on 
                            A.codigo = B.tabla        
                            where is_inspector = AVALUADOR
                            and A.tabla = 'cu_esp_inspector'

   -- INI JAR REQ 266
   if @@error <> 0
   begin
      if @i_batch = 'S' return 1905001
      else
      begin
         /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1905001
         return 1 
      end
   end  

   if @i_batch = 'S'
   begin
      select OFICINA,         DESC_OFICINA,       GARANTIA,
             TIPO,            DESCRIPCION,        NOMBRE_CLIENTE,
             CIUDAD,          FECHA_ANT,          ESTADO_ANT,
             NOMBRE_AVAL_ANT, NOMBRE_AVALUADOR,   DETALLE
        into cu_gar_por_visitar
        from #garporvisit_tmp
       order by OFICINA, TIPO, GARANTIA       
   end  -- if @i_batch = 'S'
   else
   begin
      select @i_custodia = isnull(@i_custodia,0)
      
      select top 20
             GARANTIA,        TIPO,            DESCRIPCION,
             NOMBRE_CLIENTE,  OBLIGACIONES,    FECHA_ANT,
             AVAL_ANT,        NOMBRE_AVAL_ANT, ESTADO_ANT,
             CIUDAD,          AVALUADOR,       NOMBRE_AVALUADOR,
             DETALLE
        from #garporvisit_tmp
       where GARANTIA > @i_custodia
       order by GARANTIA, TIPO
      
      if @@rowcount = 0
      begin
         if @i_tipo is null 
         begin
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 1901003
            return 1 -- No existen registros
         end 
      end
   end  -- else -- if @i_batch = 'S'
   -- FIN JAR REQ 266
end

if @i_operacion = 'S' /* Busca las prendas a inspeccionar para el reporte */
begin



   set rowcount 20
   select distinct 
   AVALUADOR           = is_inspector,
   NOMBRE_AV           = is_nombre,
   GARANTIA            = pi_custodia,
   TIPO                = pi_tipo,  /*FPLJunio/97 Cambia tipo por descripcion gtia*/
   DIRECCION           = (select distinct(di_descripcion) from cobis..cl_direccion 
                          where di_ente = A.cg_ente and di_direccion = 1),
   Cod_direc           = en_direccion,
   Cod_ente            = cg_ente,
   TELEFONO            = (select distinct(te_valor) from cobis..cl_telefono
                         where te_ente =A.cg_ente and te_direccion = 1 and 
                         te_secuencial in (select max(te_secuencial) from cobis..cl_telefono where te_ente = A.cg_ente
                         and te_direccion = 1)),
   No_GARANTIA         = pi_codigo_externo,      
   CLIENTE             = p_p_apellido + ' ' + p_s_apellido + ' ' + en_nombre,
   DIRECCION_GARANTIA  = substring(isnull(cu_direccion_prenda,''),1,20),
   TELEFONO_GARANTIA   = isnull(cu_telefono_prenda,''),
   CIUDAD_GARANTIA     = ci_descripcion,
   INSPECCIONADO       = pi_inspeccionado   
   into #garporvisi
   from cu_custodia 
                inner join cu_por_inspeccionar on
                pi_filial          = @i_filial
                and pi_sucursal        = @i_sucursal
                and (pi_tipo           = @i_tipo_cust or @i_tipo_cust is null)
                and cu_codigo_externo  = pi_codigo_externo
                and ((pi_inspector_asig = @i_inspector and @i_modo = 3 )
                     or @i_modo <> 3)  
                        and ((pi_inspector_asig  > @i_inspector )
                     or (pi_inspector_asig  = @i_inspector) 
                        and pi_custodia   > @i_custodia 
                            or @i_custodia is null)
                and pi_inspeccionado  = 'N' --JVC DIC/2002
                and   ((@i_lote is null )
                    or (@i_lote is not null  and pi_lote =  @i_lote 
                     and pi_fenvio_carta = @i_fecha_envio_carta))
                inner join cu_cliente_garantia A on
                    A.cg_codigo_externo  = cu_codigo_externo
                    and A.cg_principal = 'D'  
                        inner join cobis..cl_ente on
                        A.cg_ente = en_ente                    
                            inner join cu_inspector on
                            is_inspector = pi_inspector_asig
                            and cu_inspeccionar  = 'S'                                                           
                                   inner join cu_tipo_custodia on
                                       tc_tipo = pi_tipo
                                       left outer join cobis..cl_ciudad on
                                         cu_ciudad_prenda = ci_ciudad


--select @w_entecod = Convert(varchar(10),Cod_ente)

--print 'Cod_ente %1!', @w_entecod
--print 'Cod_direc %1!', Cod_direc

--begin 
--select * from #garporvisi
--end



    update #garporvisi
    set DIRECCION = convert(varchar(30),di_descripcion)
    from  cobis..cl_direccion
    where  di_ente      = Cod_ente
    and    di_direccion = Cod_direc
    if @@error <> 0 
    begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905001
      return 1 
     end


    update #garporvisi
    set TELEFONO = convert(varchar(30),te_valor)
    from  cobis..cl_telefono
    where  te_ente      = Cod_ente
    and    te_direccion = Cod_direc
    if @@error <> 0 
    begin
      /* Error en insercion de registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1905001
      return 1 
     end




    Select  
    AVALUADOR,         NOMBRE_AV,      GARANTIA, TIPO,
    CLIENTE,           DIRECCION,      TELEFONO, No_GARANTIA,
    DIRECCION_GARANTIA,TELEFONO_GARANTIA, CIUDAD_GARANTIA,INSPECCIONADO
    from #garporvisi
    order by AVALUADOR, No_GARANTIA

   --Envia la fecha maxima de recepcion cuando se busca una fecha anterior sino nada
    if @@rowcount = 0 
    begin
       exec cobis..sp_cerror
       @t_debug = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 1901003
       return 1 -- No existen registros
    end       

   if @i_lote is not null
   begin
      select @w_fecha = max (ci_fmaxrecep)
      from  cu_control_inspector,cu_por_inspeccionar 
      where ci_fenvio_carta = @i_fecha_envio_carta
      and   ci_lote         = @i_lote 
      and   pi_lote         = @i_lote 
      and   ci_lote         = pi_lote
      and   pi_fenvio_carta = @i_fecha_envio_carta
      select convert (varchar(10), @w_fecha, @i_formato_fecha)
   end

   return 0
end
go

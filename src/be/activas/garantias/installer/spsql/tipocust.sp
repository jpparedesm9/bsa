/************************************************************************/
/*  Archivo:                tipocust.sp                                 */
/*  Stored procedure:       sp_tipo_custodia                            */
/*  Base de datos:          cob_custodia                                */
/*  Producto:               garantias                                   */
/*  Disenado por:           Rodrigo Garces                              */
/*                          Luis Alfredo Castellanos                    */
/*  Fecha de escritura:     Junio-1995                                  */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones de:                         */
/*  Ingreso / Modificacion / Eliminacion / Consulta y Busqueda          */
/*  de los Diferentes Tipos de Garantias                                */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  Jun/1995                Emision Inicial                             */
/*  Oct/2002    Gonzalo S.          Parametro tipo de garantia          */ 
/*                  Especial                                            */
/************************************************************************/
use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_tipo_custodia')
    drop proc sp_tipo_custodia
go
create proc sp_tipo_custodia (
   @s_ssn                int            = null,
   @s_date               datetime       = null,
   @s_user               varchar(14)    = null,
   @s_term               varchar(64)    = null,
   @s_corr               char(1)        = null,
   @s_ssn_corr           int            = null,
   @s_ofi                smallint       = null,
   @t_rty                char(1)        = null,
   @t_trn                smallint       = null,
   @t_debug              char(1)        = 'N',
   @t_file               varchar(14)    = null,
   @t_from               varchar(30)    = null,
   @i_operacion          char(1)        = null,
   @i_modo               smallint       = null,
   @i_tipo               varchar(64)    = null,
   @i_tipo_superior      varchar(64)    = null,
   @i_descripcion        varchar(255)   = null,
   @i_periodicidad       varchar(10)    = null,
   @i_cond1              varchar(10)    = null,
   @i_param1             varchar(64)    = null,
   @i_filial             tinyint        = null,
   @i_cuenta             char(20)       = null,
   @i_contabilizar       char(1)        = null,
   @i_porcentaje         money          = null,
   @i_adecuada           char(1)        = null,
   @i_tipo_bien          char(1)        = null,
   @i_porcen_cobertura   float          = null,     
   @i_monetaria          char(1)        = null,     
   @i_garan_empleado     char(1)        = null,
   @i_clase_custodia     char(1)        = null, --emg feb-20-02
   @i_multimoneda        char(1)        = null,
   @i_agotada            char(1)        = null,
   @i_ctr_vencimiento    char(1)        = null,
   @i_estado             char(1)        = null,
   @i_colat_adic         char(1)        = 'N'   --dfp dic-20-2012
   
)
as

declare
   @w_today              datetime,     /* fecha del dia */ 
   @w_return             int,          /* valor que retorna */
   @w_sp_name            varchar(32),  /* nombre stored proc*/
   @w_existe             tinyint,      /* existe el registro*/
   @w_tipo               varchar(64),
   @w_tipo_superior      varchar(64),
   @w_tipo_superior1     varchar(64),
   @w_tipo_superior2     varchar(64),
   @w_tipo_superior3     varchar(64),
   @w_padre              varchar(64),
   @w_descripcion        varchar(255),
   @w_periodicidad       varchar(10),
   @w_des_tiposup        varchar(64),
   @w_des_periodicidad   varchar(64),
   @w_contabilizar       char(1),
   @w_porcentaje         float,
   @w_valor              tinyint,
   @w_secservicio        int,
   @w_adecuada           char(1),
   @w_porcen_cobertura   float,     
   @w_des_adecuada       varchar(64),   
   @w_monetaria          char(1),      
   @w_des_tipo_bien      varchar(64),  
   @w_tipo_bien          char(1),   
   @w_visita             char(1),
   @w_garan_empleado     char(1),
   @w_des_clase          varchar(64), --emg feb-20-02
   @w_clase              varchar(10), --emg feb-20-02
   @w_garesp             varchar(30), --gsr Oct-24-2002
   @w_siguiente_tipo     varchar(64),
   @w_especial           char(1),
   @w_tipo_superiorx     varchar(64),
   @w_multimoneda        char(1),
   @w_agotada            char(1),
   @w_ctr_vencimiento    char(1),
   @w_estado             char(1),
   @w_tipo_inferior      varchar(64),
   @w_colat_adic         char(1),  --dfp Dic-20-2012
   @w_comparte           char(1),   --dfp Ene-03-2013
   @w_spid               int


select @w_today = convert(varchar(10),@s_date,101)
select @w_sp_name = 'sp_tipo_custodia'

--select @w_spid = @@spid

--delete from cob_custodia..tmp_tipocustodia where spid = @w_spid

/***Trae Parametro tipo de Garantia Especial ****/
select @w_garesp = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'GARESP' 
and pa_producto = 'GAR'
set transaction isolation level read uncommitted

/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 19120 and @i_operacion = 'I') or
   (@t_trn <> 19121 and @i_operacion = 'U') or
   (@t_trn <> 19122 and @i_operacion = 'D') or
   (@t_trn <> 19123 and @i_operacion = 'V') or
   (@t_trn <> 19124 and @i_operacion = 'S') or
   (@t_trn <> 19125 and @i_operacion = 'Q') or
   (@t_trn <> 19126 and @i_operacion = 'A') or
   (@t_trn <> 19127 and @i_operacion = 'H'  or 
    @t_trn <> 19127 and @i_operacion = 'E') or
   (@t_trn <> 19128 and @i_operacion = 'B')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,

    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 1901006
    return 1 
end
-- pga 18may2001
select @w_secservicio = @@spid


/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A' and @i_operacion <> 'H'
begin
    select 
         @w_tipo                = tc_tipo,
         @w_tipo_superior       = tc_tipo_superior,
         @w_descripcion         = tc_descripcion,
         @w_periodicidad        = tc_periodicidad,
         @w_contabilizar        = tc_contabilizar,
         @w_porcentaje          = tc_porcentaje,
         @w_adecuada            = tc_adecuada,
         @w_porcen_cobertura    = isnull(tc_porcen_cobertura,100),  
         @w_monetaria           = tc_monetaria,
         @w_tipo_bien           = tc_tipo_bien,
         @w_garan_empleado      = tc_garan_empleado,
         @w_clase               = tc_clase,
         @w_multimoneda         = tc_multimoneda,    
         @w_agotada             = tc_agotada,        
         @w_ctr_vencimiento     = tc_ctr_vencimiento,
         @w_estado              = tc_estado
      
    from cob_custodia..cu_tipo_custodia 
    where 
         tc_tipo = @i_tipo
         and tc_tipo_superior is not null   /* PHsc1 */
         and tc_tipo <> 'CDTPROP'
         and tc_estado = 'V'

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end


if @i_operacion in ('F', 'U')
begin
    select 
         @w_tipo                = tc_tipo,
         @w_tipo_superior       = tc_tipo_superior,
         @w_descripcion         = tc_descripcion,
         @w_periodicidad        = tc_periodicidad,
         @w_contabilizar        = tc_contabilizar,
         @w_porcentaje          = tc_porcentaje,
         @w_adecuada            = tc_adecuada,
         @w_porcen_cobertura    = isnull(tc_porcen_cobertura,100),  
         @w_monetaria           = tc_monetaria,
         @w_tipo_bien           = tc_tipo_bien,
         @w_garan_empleado      = tc_garan_empleado,
         @w_clase               = tc_clase,
         @w_multimoneda         = tc_multimoneda,    
         @w_agotada             = tc_agotada,        
         @w_ctr_vencimiento     = tc_ctr_vencimiento,
         @w_estado              = tc_estado
      
    from cob_custodia..cu_tipo_custodia 
    where 
         tc_tipo = @i_tipo
         and tc_tipo_superior is not null   /* PHsc1 */
         and tc_tipo <> 'CDTPROP'

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0
end

/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if @i_tipo is  NULL 
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 1901001
        return 1 
    end

    if @i_tipo_superior is not NULL
       if exists (select * from cu_tipo_custodia  
                   where tc_tipo = @i_tipo_superior)
       begin
          select @w_valor = 1
       end
       else
       begin
       /* No existe codigo Superior */
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1901014
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
        @t_from  = @w_sp_name,
        @i_num   = 1901002
        return 1 
    end


    begin tran  
       insert into cu_tipo_custodia(
       tc_tipo,         tc_tipo_superior,     tc_descripcion,
       tc_periodicidad, tc_contabilizar,      tc_porcentaje,
       tc_adecuada,     tc_porcen_cobertura,  tc_monetaria,
       tc_tipo_bien,    tc_garan_empleado,    tc_clase,
       tc_multimoneda,  tc_agotada,           tc_ctr_vencimiento,
       tc_estado)
       values (
       @i_tipo,         @i_tipo_superior,    @i_descripcion,
       @i_periodicidad, @i_contabilizar,     @i_porcentaje,
       @i_adecuada,     @i_porcen_cobertura, @i_monetaria,
       @i_tipo_bien,    @i_garan_empleado,   @i_clase_custodia,
       @i_multimoneda,  @i_agotada,          @i_ctr_vencimiento,
       @i_estado)



         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903001
             return 1 
         end

        /* Ingresar en tabla de Colaterales Adicionales */

             insert into cu_colat_adic(ca_codigo_cust, ca_comparte)
             values (@i_tipo, @i_colat_adic )

        if @@error <> 0 
           begin
            /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1912117
             return 1 
         end

         /* Transaccion de Servicio */
         /***************************/
         insert into ts_tipo_custodia values (
         @w_secservicio,@t_trn,'N',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_tipo_custodia', @i_tipo,
         @i_tipo_superior, @i_descripcion, @i_periodicidad,
         @i_contabilizar, @i_monetaria,@i_tipo_bien,@i_garan_empleado)    /*XVE%*/



         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
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
        @t_from  = @w_sp_name,
        @i_num   = 1905002

        return 1 
    end

    begin tran
         update cob_custodia..cu_tipo_custodia set 
         tc_tipo_superior    = @i_tipo_superior,
         tc_descripcion      = @i_descripcion,
         tc_periodicidad     = @i_periodicidad,
         tc_contabilizar     = @i_contabilizar,
         tc_porcentaje       = @i_porcentaje,
         tc_adecuada         = @i_adecuada,
         tc_porcen_cobertura = @i_porcen_cobertura,  
         tc_monetaria        = @i_monetaria,
         tc_tipo_bien        = @i_tipo_bien,
         tc_clase            = @i_clase_custodia,
         tc_multimoneda      = @i_multimoneda,     
         tc_agotada          = @i_agotada,         
         tc_ctr_vencimiento  = @i_ctr_vencimiento ,
         tc_estado           = @i_estado
         where 
         tc_tipo = @i_tipo
         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1905001
             return 1 
         end

         /* Acrtualizar en tabla de Colaterales Adicionales */

          update cu_colat_adic
          set ca_comparte = @i_colat_adic
          where ca_codigo_cust = @i_tipo

          if @@rowcount = 0 begin
          insert into cu_colat_adic(ca_codigo_cust, ca_comparte)
          values (@i_tipo, @i_colat_adic )

          if @@error <> 0 
            begin
            /* Error en Actualizacion de registro */
               exec cobis..sp_cerror
               @t_from  = @w_sp_name,
               @i_num   = 1912118
               return 1 
            end
          end

         /* Transaccion de Servicio */
         /***************************/

         insert into ts_tipo_custodia values (
         @w_secservicio,@t_trn,'P',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_tipo_custodia', @w_tipo,
         @w_tipo_superior, @w_descripcion, @w_periodicidad,
         @w_contabilizar, @w_monetaria,@w_tipo_bien,@w_garan_empleado)
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end

            

         /* Transaccion de Servicio */

         /***************************/
         -- PGA 14mar2001
         -- exec @w_secservicio = sp_gen_sec
         insert into ts_tipo_custodia values (
         @w_secservicio,@t_trn,'A',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_tipo_custodia', @i_tipo,
         @i_tipo_superior, @i_descripcion, @i_periodicidad,
         @i_contabilizar, @i_monetaria,@i_tipo_bien,@i_garan_empleado)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
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

    if exists (select * from cu_tipo_custodia
               where tc_tipo_superior = @i_tipo)
    begin
    /* Existen tipos Hijos que no han sido eliminados */
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1907003
        return 1 
    end

    if exists (select * from cu_custodia
               where cu_tipo = @i_tipo and cu_estado not in ('A','C'))
    begin
        exec cobis..sp_cerror
        @t_from  = @w_sp_name,
        @i_num   = 1907004
        return 1 
    end

    begin tran
       delete cob_custodia..cu_tipo_custodia
       where 
       tc_tipo = @i_tipo
       if @@error <> 0 
      begin
          /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
        @i_num   = 1907001
          return 1 
        end




       delete cu_item            
       where it_tipo_custodia = @i_tipo                          
       if @@error <> 0
       begin
         /*Error en eliminacion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1907001
          return 1 
       end

         /* Eliminar en tabla de Colaterales Adicionales */

         delete cu_colat_adic
         where 
         ca_codigo_cust = @i_tipo

         if @@error <> 0 
            begin
            /* Error en Eliminacion de registro */
                exec cobis..sp_cerror
                @t_from  = @w_sp_name,
                @i_num   = 1912119
             return 1 
            end

         /* Transaccion de Servicio */
         /***************************/
         insert into ts_tipo_custodia values (
         @w_secservicio,@t_trn,'B',
         @s_date,@s_user,@s_term,
         @s_ofi,'cu_tipo_custodia', @w_tipo,
         @w_tipo_superior, @w_descripcion, @w_periodicidad,
         @w_contabilizar, @w_monetaria,@w_tipo_bien,@w_garan_empleado)

         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_from  = @w_sp_name,
             @i_num   = 1903003
             return 1 
         end
    commit tran
    return 0
end

/* Consulta opcion VALUE */
/*************************/

if @i_operacion = 'V'
begin
   select @w_descripcion      = tc_descripcion,
          @w_periodicidad     = tc_periodicidad,
          @w_porcen_cobertura = tc_porcen_cobertura, 
          @w_adecuada         = tc_adecuada, 
          @w_tipo_bien        = tc_tipo_bien,
          @w_contabilizar     = tc_contabilizar,
          @w_monetaria        = tc_monetaria,
          @w_garan_empleado   = tc_garan_empleado,
          @w_clase            = tc_clase,
          @w_estado           = tc_estado

   from cu_tipo_custodia 
   where tc_tipo = @i_tipo 
   if @@rowcount = 0 
   begin
   /* No existe el registro */
      exec cobis..sp_cerror
      @t_from  = @w_sp_name,
      @i_num   = 1901005
      return 1 
   end

-- Req 343
select  @w_comparte = ca_comparte
from cob_custodia..cu_colat_adic
where ca_codigo_cust = @i_tipo      
      
/* descripcion de periodicidad,tipo bien y adecuada
    select @w_des_periodicidad = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_des_periodicidad'
      and A.codigo = @w_periodicidad
      set transaction isolation level read uncommitted
*/


    select @w_des_periodicidad = td_descripcion
    from   cob_cartera..ca_tdividendo
    where  td_tdividendo = @w_periodicidad
    
    select @w_des_tipo_bien = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_tipo_bien'
      and A.codigo = @w_tipo_bien
      set transaction isolation level read uncommitted


   select @w_des_adecuada = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_caracter'
      and A.codigo = @w_adecuada
      set transaction isolation level read uncommitted

   select @w_des_clase = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_clase_custodia'
      and A.codigo = @w_clase
      set transaction isolation level read uncommitted


   select @w_descripcion,
          @w_periodicidad,
          @w_porcen_cobertura, 
          @w_adecuada,
          @w_tipo_bien,
          @w_des_periodicidad, 
          @w_des_tipo_bien,
          @w_des_adecuada,         
          @w_contabilizar,
          @w_monetaria,
          @w_garan_empleado,
          @w_clase, --emg
          @w_des_clase,
          @w_estado,
          @w_comparte --dfp


end 

/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'Q'
begin

   if @w_existe = 1
   begin    
      select @w_tipo_superior1 = @w_tipo_superior,
             @w_tipo_superior2 = @w_tipo_superior
     
      while @w_tipo_superior1 is not null
      begin
        select @w_tipo_superior1 = tc_tipo_superior
        from cu_tipo_custodia
        where tc_tipo =  @w_tipo_superior2
        
         if @w_tipo_superior1 is not null
            select @w_tipo_superior2 = @w_tipo_superior1
      end

      select @w_des_tiposup = tc_descripcion
      from cu_tipo_custodia
      where tc_tipo = @w_tipo_superior

      select @w_porcentaje = tc_porcentaje
      from cu_tipo_custodia 
      where tc_tipo = @i_tipo 

/*      select @w_des_periodicidad = A.valor
      from cobis..cl_catalogo A,cobis..cl_tabla B
      where B.codigo = A.tabla
      and B.tabla = 'cu_des_periodicidad'
      and A.codigo = @w_periodicidad
      set transaction isolation level read uncommitted
*/

    select @w_des_periodicidad = td_descripcion
    from   cob_cartera..ca_tdividendo
    where  td_tdividendo = @w_periodicidad
    


      select @w_des_adecuada = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_admisible' and
      A.codigo = @w_adecuada and
      B.codigo = A.tabla
      set transaction isolation level read uncommitted

      select @w_des_tipo_bien = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_tipo_bien' and
      A.codigo = @w_tipo_bien and
      B.codigo = A.tabla
      set transaction isolation level read uncommitted

      if @w_periodicidad = 'N'
         select @w_visita = 'N'
      else
         select @w_visita = 'S'


      select @w_des_clase = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_clase_custodia' and
      A.codigo = @w_clase and
      B.codigo = A.tabla
      set transaction isolation level read uncommitted


     --hallar el superior emg ene-31-03

     select @w_tipo_superiorx = @w_tipo_superior

    while (1=1)
    begin 
       

        /** ASIGNO EL TIPO SUPERIOR AL TIBO BUSCADO **/ 
        select @w_tipo_superior3 = tc_tipo_superior
        from   cu_tipo_custodia 
        where  tc_tipo = @w_tipo_superiorx
 

        if @w_tipo_superior3 is null
        begin
            select @w_padre = @w_tipo_superiorx
            break
        end

        select @w_tipo_superiorx = @w_tipo_superior3
    end


     --emg feb-05-03



        
       select @w_especial = 'N'        

       --hallar siguiente tipo teniendo el padre

        set rowcount 1
        select @w_siguiente_tipo = tc_tipo 
        from cu_tipo_custodia 
        where tc_tipo > @w_garesp
        and   tc_tipo_superior = @w_padre
        order by tc_tipo
        set rowcount 0

  
       
        if exists (select tc_tipo
                   from cu_tipo_custodia
                   where tc_tipo = @w_garesp
                   and   tc_tipo = @w_padre)
                   -->= @w_garesp
                    -- and tc_tipo < @w_siguiente_tipo
                   --  and tc_tipo = @i_tipo)
         select @w_especial = 'S'

        
        /* Consultar en tabla de Colaterales Adicionales */
      select @w_colat_adic = ca_comparte 
      from cu_colat_adic
      where ca_codigo_cust = @i_tipo
      
      select
      @w_tipo,
      @w_tipo_superior,
      @w_des_tiposup,               
      @w_descripcion,
      @w_periodicidad,
      @w_des_periodicidad,
      @w_contabilizar, 
      @w_porcen_cobertura,
      @w_adecuada,
      @s_ofi,
      @w_clase,  
      @w_agotada,          
      @w_monetaria,       
      @w_tipo_bien,
      @w_des_tipo_bien,
      @w_tipo_superior2,
      @w_visita,
      @w_visita,
      @w_clase,--emg
      @w_des_clase, --emg
      @w_especial ,
      @w_estado,
      @w_colat_adic --dfp
      
  
      return 0
   end    
   else
      return 1 
end


/* Consulta opcion FIND */
/*************************/
if @i_operacion = 'F'
begin

   if @w_existe = 1
   begin    
     select @w_tipo_inferior = tc_tipo
     from cu_tipo_custodia
     where tc_tipo_superior = @i_tipo

     if @w_tipo_inferior is not null
       return 1

      select @w_tipo_superior1 = @w_tipo_superior,
             @w_tipo_superior2 = @w_tipo_superior
      while @w_tipo_superior1 is not null
      begin
        select @w_tipo_superior1 = tc_tipo_superior
        from cu_tipo_custodia
        where tc_tipo =  @w_tipo_superior2
        
        if @w_tipo_superior1 is not null
            select @w_tipo_superior2 = @w_tipo_superior1
      end
      
      select @w_des_tiposup = tc_descripcion
      from cu_tipo_custodia
      where tc_tipo = @w_tipo_superior
      
      select @w_porcentaje = tc_porcentaje,
             @w_estado     = tc_estado
      from cu_tipo_custodia 
      where tc_tipo = @i_tipo 
      
      select @w_des_periodicidad = td_descripcion
      from   cob_cartera..ca_tdividendo
      where  td_tdividendo = @w_periodicidad
    
      select @w_des_adecuada = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_admisible' and
      A.codigo = @w_adecuada and
      B.codigo = A.tabla
      set transaction isolation level read uncommitted

      select @w_des_tipo_bien = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_tipo_bien' and
      A.codigo = @w_tipo_bien and
      B.codigo = A.tabla
      set transaction isolation level read uncommitted

      if @w_periodicidad = 'N'
         select @w_visita = 'N'
      else
         select @w_visita = 'S'

      select @w_des_clase = A.valor
      from cobis..cl_catalogo A, cobis..cl_tabla B
      where B.tabla = 'cu_clase_custodia' and
      A.codigo = @w_clase and
      B.codigo = A.tabla
      set transaction isolation level read uncommitted

      select @w_tipo_superiorx = @w_tipo_superior

      while (1=1)
      begin 
          
      
          /** ASIGNO EL TIPO SUPERIOR AL TIBO BUSCADO **/ 
          select @w_tipo_superior3 = tc_tipo_superior
          from   cu_tipo_custodia 
          where  tc_tipo = @w_tipo_superiorx
      
      
          if @w_tipo_superior3 is null
          begin
              select @w_padre = @w_tipo_superiorx
            break
          end
      
          select @w_tipo_superiorx = @w_tipo_superior3
      end
  
      select @w_especial = 'N'        

      --hallar siguiente tipo teniendo el padre

        set rowcount 1
        select @w_siguiente_tipo = tc_tipo 
        from cu_tipo_custodia 
        where tc_tipo > @w_garesp
        and   tc_tipo_superior = @w_padre
        order by tc_tipo
        set rowcount 0

        if exists (select tc_tipo
                   from cu_tipo_custodia
                   where tc_tipo >= @w_garesp
                     and tc_tipo < @w_siguiente_tipo
                     and tc_tipo = @i_tipo)
         select @w_especial = 'S'
         
      /* Consultar en tabla de Colaterales Adicionales */
      select @w_colat_adic = ca_comparte 
      from cu_colat_adic
      where ca_codigo_cust = @i_tipo


      select
      @w_tipo,
      @w_tipo_superior,
      @w_des_tiposup,               
      @w_descripcion,
      @w_periodicidad,
      @w_des_periodicidad,
      @w_contabilizar, 
      @w_porcen_cobertura,
      @w_adecuada,
      @s_ofi,
      @w_porcen_cobertura,  
      @w_des_adecuada,          
      @w_monetaria,       
      @w_tipo_bien,
      @w_des_tipo_bien,
      @w_tipo_superior2,
      @w_visita,
      @w_garan_empleado,
      @w_clase,--emg
      @w_des_clase, --emg
      @w_especial, --emg ene-31-02
      @w_multimoneda,      
      @w_agotada,          
      @w_ctr_vencimiento,
      @w_estado,
      @w_colat_adic --dfp
      
  
      return 0
   end    
   else
      return 1 
end


 /* Todos los datos de la tabla */
 /*******************************/
if @i_operacion = 'A'
begin
   set rowcount 20
   if @i_tipo is null
      select @i_tipo = @i_param1
      if @i_modo = 0 
      begin
         select "TIPO" = tc_tipo,
         "DESCRIPCION" = substring(tc_descripcion,1,25)
         from cu_tipo_custodia  
         if @@rowcount = 0
         begin 
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901003
            return 1 
         end
      end
      else 
      begin
         select tc_tipo,
         tc_descripcion 
         from cu_tipo_custodia  
         where tc_tipo > @i_tipo  
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901004
            return 1 
         end
      end
end

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0 
   begin
      select 
      "TIPO" = tc_tipo,
      "TIPO SUPERIOR" = tc_tipo_superior
      from cu_tipo_custodia  
      where (tc_tipo like @i_tipo or @i_tipo is null)
      and (tc_tipo_superior = @i_tipo_superior or @i_tipo_superior is null)
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901003
         return 1 
      end    
   end
   else 
   begin
      select
      "TIPO" = tc_tipo,
      "TIPO SUPERIOR" = tc_tipo_superior
      from cu_tipo_custodia 
      where tc_tipo > @i_tipo  
      and (tc_tipo like @i_tipo or @i_tipo is null)
      and (tc_tipo_superior = @i_tipo_superior or @i_tipo_superior is null)
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1901004
         return 1 
      end
   end
end

if @i_operacion = 'C'
begin
   if @i_cond1 = '1'
      select @i_tipo = @w_garesp
      if @i_modo = 0 
      begin
         select
         "TIPO" = substring(tc_tipo,1,20), 
         "DESCRIPCION" = tc_descripcion,
         "CLASE CUSTODIA" =tc_adecuada  --FPL1 
         from   cu_tipo_custodia     
         where  isnull(tc_tipo_superior,' ') = isnull(@i_tipo,' ')
         and    tc_tipo <> 'CDTPROP'
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901021
            return 1 
         end
      end
      else
      begin       

         select
         "TIPO" = substring(tc_tipo,1,20), 
         "DESCRIPCION" = tc_descripcion,
         "CLASE CUSTODIA" = tc_adecuada   --FPL1
         from cu_tipo_custodia
     where tc_tipo > @i_tipo and
         (tc_tipo_superior = @i_tipo)
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901004
            return 1 
         end
      end
end

if @i_operacion = 'H'
begin
   if @i_cond1 = '1'
      select @i_tipo = @w_garesp
      if @i_modo = 0 
      begin
          select
         "TIPO" = substring(tc_tipo,1,20), 
         "DESCRIPCION" = tc_descripcion,
         "CLASE CUSTODIA" =tc_adecuada  --FPL1 
         from   cu_tipo_custodia     
         where  isnull(tc_tipo_superior,' ') = isnull(@i_tipo,' ')
         and    tc_estado   = 'V'
         and    tc_tipo <> 'CDTPROP'
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901021
            return 1 
         end
      end
      else
      begin       

         select
         "TIPO" = substring(tc_tipo,1,20), 
         "DESCRIPCION" = tc_descripcion,
         "CLASE CUSTODIA" = tc_adecuada   --FPL1
         from  cu_tipo_custodia
     where tc_tipo > @i_tipo 
         and   tc_tipo_superior = @i_tipo
         and   tc_estado    = 'V'
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901004
            return 1 
         end
      end
end


if @i_operacion = 'E'
begin
        select @i_tipo = @w_garesp

        select @w_tipo = @i_tipo

       --hallar el padre
           
    while (1=1)
    begin 
        /** ASIGNO EL TIPO SUPERIOR AL TIBO BUSCADO **/ 
        select @w_tipo_superior3 = tc_tipo_superior
        from   cu_tipo_custodia 
        where  tc_tipo = @w_tipo
 
        
        if @w_tipo_superior3 is null
        begin
            select @w_padre = @w_tipo
            break
        end

        select @w_tipo = @w_tipo_superior3
    end

       --hallar siguiente tipo teniendo el padre

        --set rowcount 1
        
        select @w_siguiente_tipo = tc_tipo
        from cu_tipo_custodia 
        where tc_tipo > @i_tipo
        and   tc_tipo_superior = @w_padre
        order by tc_tipo
        
       --set rowcount 0

        select
        "TIPO" = substring(tc_tipo,1,20), 
        "DESCRIPCION" = tc_descripcion,
        "CLASE CUSTODIA" =tc_adecuada  --FPL1 
        from cu_tipo_custodia     
        where ((tc_tipo > @i_tipo) and (tc_tipo <= @w_siguiente_tipo))
        order by tc_tipo
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901021
            return 1 
         end
      end


if @i_operacion = 'B'   -- Cuenta Contable
begin
   select cu_nombre
     from cob_conta..cb_cuenta
     where cu_empresa     = @i_filial
       and cu_cuenta      = @i_cuenta
       and cu_movimiento  = 'S'
         if @@rowcount = 0
         begin
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file, 
           @t_from  = @w_sp_name,
           @i_num   = 1901009
           return 1 
         end
end

--busqueda del nivel ma bajo de custodias
if @i_operacion = 'N'
begin

     set rowcount 20
   if @i_tipo is null
      select @i_tipo = @i_param1
      if @i_modo = 0 
      begin
         select "TIPO" = tc_tipo,
         "DESCRIPCION" = substring(tc_descripcion,1,25)
         from cu_tipo_custodia  
         where   tc_tipo != tc_tipo_superior 
         if @@rowcount = 0
         begin 
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901003
            return 1 
         end
      end
      else 
      begin
         select tc_tipo,
         tc_descripcion 
         from cu_tipo_custodia  
         where tc_tipo > @i_tipo  
         if @@rowcount = 0
         begin
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1901004
            return 1 
         end
      end
end

go


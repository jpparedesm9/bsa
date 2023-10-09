/***********************************************************************/
/*    Archivo:            cr_impdo.sp                                  */
/*    Stored procedure:        sp_imp_documento                        */
/*    Base de Datos:            cob_credito                            */
/*    Producto:            Credito                                     */
/*    Disenado por:            Myriam Davila                           */
/*    Fecha de Documentacion:     15/Ago/95                            */
/***********************************************************************/
/*            IMPORTANTE                                               */
/*    Este programa es parte de los paquetes bancarios propiedad de    */ 
/*    "MACOSA",representantes exclusivos para el Ecuador de la         */
/*    AT&T                                                             */
/*    Su uso no autorizado queda expresamente prohibido asi como       */
/*    cualquier autorizacion o agregado hecho por alguno de sus        */
/*    usuario sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante               */
/***********************************************************************/
/*            PROPOSITO                                                */
/*    Este stored procedure permite realizar operaciones DML           */
/*    Search y Query en la tabla cr_imp_documento                      */
/***********************************************************************/
/*            MODIFICACIONES                                           */
/*    FECHA        AUTOR            RAZON                              */
/*    15/Ago/95    Ivonne Ordonez        Emision Inicial               */
/*    21/Jul/95    Paul Ortiz            Correccion FIltro             */
/*    31/07/2019   ACHP                  OP.'S'se a�ade filtro estado<>C*/
/*    20/01/2021   JCASTRO               REQ#147999                    */
/***********************************************************************/
  
use cob_credito
go

if exists (select * from sysobjects where name = 'sp_imp_documento')
    drop proc sp_imp_documento
go

create proc sp_imp_documento (
   @s_ssn                int      = null,
   @s_user               login    = null,
   @s_sesn               int    = null,
   @s_term               descripcion = null,
   @s_date               datetime = null,
   @s_srv                varchar(30) = null,
   @s_lsrv               varchar(30) = null,
   @s_rol                smallint = null,
   @s_ofi                smallint  = null,
   @s_org_err            char(1) = null,
   @s_error              int = null,
   @s_sev                tinyint = null,
   @s_msg                descripcion = null,
   @s_org                char(1) = null,
   @t_rty                char(1)  = null,
   @t_trn                smallint = null,
   @t_debug              char(1)  = 'N',
   @t_file               varchar(14) = null,
   @t_from               varchar(30) = null,
   @i_operacion          char(1)  = null,
   @i_modo               smallint = null,
   @i_documento          smallint  = null,
   @i_toperacion         catalogo  = null,
   @i_producto           catalogo  = null,
   @i_moneda             tinyint  = null,
   @i_descripcion        descripcion  = null,
   @i_template           descripcion  = null,
   @i_mnemonico          catalogo  = null,
   @i_valor              varchar(10) = null,
   @i_tipo               char(1) = null, --SAL 04/07/1999
   @i_dato               catalogo = null,
   @i_subopcion          smallint = 0,   -- 1 Medios de Aprobacion
   @i_medio              char(1) = NULL,
   @i_tramite            INT = null
)
as
declare
@w_today              datetime,     /* fecha del dia */ 
@w_return             int,          /* valor que retorna */
@w_sp_name            varchar(32),  /* nombre stored proc*/
@w_existe             tinyint,      /* existe el registro*/
@w_documento          smallint,
@w_toperacion         catalogo,
@w_desc_toperacion    descripcion,
@w_producto           catalogo,
@w_moneda             tinyint,
@w_desc_moneda        descripcion,
@w_descripcion        descripcion,
@w_template           descripcion,
@w_mnemonico          catalogo,
@w_cont               tinyint,
@w_tipo               char(1), --SAL 04/07/1999
@w_dato               catalogo,
@w_medio              char(1),
@w_expromision        VARCHAR(10),
@o_documento          INT = 0,
@w_tr_producto        varchar (10),
@w_linea_credito      INT,
@w_estado_proc_neg    char(1),
@w_meses_expiracion   int
   
select @w_today = @s_date
select @w_sp_name = 'sp_imp_documento'
/* Debug */
/*********/
if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file = @t_file
        select '/** Stored Procedure **/ ' = @w_sp_name,
        s_ssn              = @s_ssn,
         s_user            = @s_user,
        s_sesn             = @s_sesn,
        s_term             = @s_term,
        s_date             = @s_date,
        s_srv              = @s_srv,
        s_lsrv             = @s_lsrv,
        s_rol              = @s_rol,
        s_ofi              = @s_ofi,
        s_org_err          = @s_org_err,
        s_error            = @s_error,
        s_sev              = @s_sev,
        s_msg              = @s_msg,
        s_org              = @s_org,
        t_trn              = @t_trn,
        t_file             = @t_file,
        t_from             = @t_from,
        i_operacion        = @i_operacion,
        i_modo             = @i_modo,
        i_documento        = @i_documento,
        i_toperacion       = @i_toperacion,
        i_producto         = @i_producto,
        i_moneda           = @i_moneda, 
        i_descripcion      = @i_descripcion,
        i_template         = @i_template, 
        i_mnemonico        = @i_mnemonico,
        i_tipo             = @i_tipo,
        i_dato             = @i_dato 
    exec cobis..sp_end_debug
end
/***********************************************************/
/* Codigos de Transacciones                                */
if (@t_trn <> 21033 and @i_operacion = 'I') or
   (@t_trn <> 21133 and @i_operacion = 'U') or
   (@t_trn <> 21233 and @i_operacion = 'D') or
   (@t_trn <> 21433 and @i_operacion = 'S') or
   (@t_trn <> 21533 and @i_operacion = 'Q')
begin
/* tipo de transaccion no corresponde */
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = 2101006
    return 1 
end

select  @w_estado_proc_neg = 'P' --
/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
begin
    select 
         @w_documento   = id_documento,
         @w_toperacion  = id_toperacion,
         @w_desc_toperacion = to_descripcion,
         @w_producto    = id_producto,
         @w_moneda      = id_moneda,
         @w_desc_moneda = mo_descripcion,
         @w_descripcion = id_descripcion,
         @w_template  = id_template,
         @w_mnemonico = id_mnemonico,
         @w_tipo      = id_tipo_tramite, --SAL 04/07/1999
         @w_dato      = id_dato,   --SMPz
         @w_medio     = id_medio
    from   cob_credito..cr_imp_documento  
        LEFT OUTER JOIN cr_toperacion ON id_documento= @i_documento 
        LEFT OUTER JOIN  cobis..cl_moneda ON id_moneda = mo_moneda
    where  id_documento = @i_documento 
       and id_toperacion = to_toperacion 
     
    --LEFT OUTER JOIN Pedidos P ON P.IdCliente = C.IdCliente
       
     

    if @@rowcount > 0
            select @w_existe = 1
    else
            select @w_existe = 0

end
/* Numero secuencial correspondiente */
/*************************************/
if @i_operacion = 'I' 
begin
    exec cobis..sp_cseqnos
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_tabla = 'cr_imp_documento',
    @o_siguiente = @o_documento out
    if @o_documento = NULL
    begin
        /* No existe tabla en tabla de secuenciales*/
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101007
        return 1 
    end
    select @i_documento = @o_documento
end
/* VALIDACION DE CAMPOS NULOS */
/******************************/
if @i_tipo = 'L' or @i_tipo = 'P' or @i_tipo = 'G' or @i_tipo = 'O'
   select @i_producto = 'CRE'
if @i_operacion = 'I' or @i_operacion = 'U'
begin
    if 
         @i_documento = NULL or 
         /*(@i_tipo <> 'L' and @i_tipo <> 'P' and @i_tipo <> 'G' and @i_toperacion = NULL) or */
         @i_producto = NULL or 
         @i_descripcion = NULL or 
         @i_template = NULL or 
         @i_mnemonico = NULL or
     @i_tipo = NULL --SAL 04/07/1999
    begin
    /* Campos NOT NULL con valores nulos */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2101001
        return 1 
    end
end

if @i_toperacion is null
   select @i_toperacion = ' '

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
        @i_num   = 2101002
        return 1 
    end
    begin tran
         insert into cr_imp_documento(
              id_documento,
              id_toperacion,
              id_producto,
              id_moneda,
              id_descripcion,
              id_template,
              id_mnemonico,
              id_tipo_tramite,    --SAL 04/07/1999
              id_dato,
              id_medio)    --SMPz
         values (
              @i_documento,
              @i_toperacion,
              @i_producto,
              @i_moneda,
              @i_descripcion,
              @i_template,
              @i_mnemonico,
              @i_tipo,    --SAL 04/07/1999
              @i_dato,
              @i_medio)  --SMPz
         if @@error <> 0 
         begin
         /* Error en insercion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103001
             return 1 
         end
         /* Transaccion de Servicio */
         /***************************/
         insert into ts_imp_documento
         values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @i_documento,
         @i_toperacion,
         @i_producto,
         @i_moneda,
         @i_descripcion,
         @i_template,
         @i_mnemonico,
         @i_tipo)
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
    commit tran 
    select @i_documento
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
        @i_num   = 2105002
        return 1 
    end
    begin tran
         update cob_credito..cr_imp_documento
         set 
              id_toperacion = @i_toperacion,
              id_producto = @i_producto,
              id_moneda = @i_moneda,
              id_descripcion = @i_descripcion,
              id_template = @i_template,
              id_mnemonico = @i_mnemonico,
              id_tipo_tramite = @i_tipo,
              id_dato = @i_dato,
              id_medio = @i_medio
    where 
         id_documento = @i_documento
         if @@error <> 0 
         begin
         /* Error en actualizacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2105001
             return 1 
         end
         /* Transaccion de Servicio */
         /***************************/
         insert into ts_imp_documento
         values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @w_documento,
         @w_toperacion,
         @w_producto,
         @w_moneda,
         @w_descripcion,
         @w_template,
         @w_mnemonico,
         @w_tipo)    
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
         /* Transaccion de Servicio */
         /***************************/
         insert into ts_imp_documento
         values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @i_documento,
         @i_toperacion,
         @i_producto,
         @i_moneda,
         @i_descripcion,
         @i_template,
         @i_mnemonico,
         @i_tipo)
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
    commit tran
end
/* Eliminacion de registros */
/****************************/
if @i_operacion = 'D'
begin
    if @w_existe = 0
    begin
    /* Registro a eliminar no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2107002
        return 1 
    end
/***** Integridad Referencial *****/
/*****                        *****/
SELECT @w_cont = count(*)  FROM cr_documento
  WHERE ( do_documento = @i_documento ) 
if @w_cont > 0
begin
    /* Registro a eliminar tiene referencias en otras tablas*/
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
        @t_from  = @w_sp_name,
        @i_num   = 2107003
        return 1 
end
    begin tran
         delete cob_credito..cr_imp_documento
    where 
         id_documento = @i_documento
         if @@error <> 0
         begin
         /*Error en eliminacion de registro */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2107001
             return 1 
         end
         /* Transaccion de Servicio */
         /***************************/
         insert into ts_imp_documento
         values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,'cr_imp_documento',@s_lsrv,@s_srv,
         @w_documento,
         @w_toperacion,
         @w_producto,
         @w_moneda,
         @w_descripcion,
         @w_template,
         @w_mnemonico,
         @w_tipo)
         if @@error <> 0 
         begin
         /* Error en insercion de transaccion de servicio */
             exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file, 
             @t_from  = @w_sp_name,
             @i_num   = 2103003
             return 1 
         end
    commit tran
end
/**** Search ****/
/****************/
if @i_operacion = 'S'
begin
   if @i_modo = 0
   BEGIN
       --set rowcount 20
       
      select @i_toperacion = tr_toperacion
      from cob_credito..cr_tramite
      where tr_tramite = @i_tramite
	  
	  select @w_meses_expiracion = datediff(ww,op_fecha_ini,op_fecha_fin) / 4 --Meses tomados en periodos de 4 semanas
      from cob_cartera..ca_operacion 
      where op_tramite           = @i_tramite
      
      --REQ#147999
	  if exists (select 1 from cob_workflow..wf_inst_proceso where io_campo_3 = @i_tramite and io_codigo_proc = '10') 
	  begin 		
	     select @i_toperacion = 'RENOVACION'
	  end
	  -- REQ#147999

	  select @i_documento = isnull(@i_documento,0)
      select @i_toperacion = isnull(@i_toperacion,'')
	  
      SELECT 
            'Documento' = id_documento,
            'Operacion' = id_toperacion+' ('+b.valor+')',
            'Producto' = id_producto,
            'Moneda' = convert(char(2),id_moneda)+' ('+mo_descripcion+')',
            'Descripcion' = id_descripcion,
            'Template' = id_template,
            'Mnemonico'= id_mnemonico,
            'TIPO'     = '',            --Policia Nacional se incluye el campo TIPO
            'MEDIO APROBACION' = 'S',    --Policia Nacional se incluye el campo MEDIO APROBACION'
            'CONDICION' = '1',            --Policia Nacional se incluye el campo CONDICION
            'ESTADO' = id_estado
      into #documentos_impresion
      FROM cob_credito..cr_imp_documento,
      cobis..cl_tabla a, 
      cobis..cl_catalogo b,
      cobis..cl_moneda
      WHERE (id_documento > @i_documento) 
      and (a.codigo = b.tabla )
      and (a.tabla  = 'ca_toperacion')
      and (id_toperacion = b.codigo) 
      and (id_moneda = mo_moneda) 
      and ((id_toperacion = @i_toperacion) or (@i_toperacion = ''))
         --and  id_estado <> 'C'
      order by id_documento
      
	  
	  if @w_meses_expiracion = 4 
	     delete #documentos_impresion where Mnemonico = 'CERCON2'
	  
	  select * from #documentos_impresion
	  
     -- set rowcount 0
   end
   else
   if @i_modo = 1
   begin
   
      set rowcount 20
      select @i_valor = isnull(@i_valor, '%')
      select @i_documento = isnull(@i_documento,0)
     
      if @i_tipo <> 'O'
      begin
         select @w_tr_producto = tr_producto, 
                @w_linea_credito = tr_linea_credito,
                @i_toperacion = tr_toperacion
           from cob_credito..cr_tramite 
          where tr_tramite = @i_tramite
             
      end
      
     -- if @i_tipo = 'O'
     -- begin
        -- select @i_toperacion = 'CASTIGO'
    --  end
   
      SELECT 
            'DOCUMENTO'   = id_documento,
            'MNEMONICO'   = id_mnemonico,
            'DESCRIPCION' = id_descripcion,
            'TEMPLATE'    = id_template,
            'DATO'           = '1',            --Policia Nacional: se aumenta campo
            'MEDIO'       = 'S',            --Policia Nacional: se aumenta campo
            'PRODUCTO'       = id_producto        --Policia Nacional: se aumenta campo
       FROM cob_credito..cr_imp_documento
      WHERE ((id_toperacion = @i_toperacion or @i_toperacion= null ) and (id_producto = @i_producto or @i_producto= null))
        and  id_moneda = isnull(@i_moneda,0) 
        and  id_documento > (isnull(@i_documento,0))
        and  id_mnemonico like @i_valor
--        and  id_estado = @w_estado_proc_neg
      ORDER BY id_documento
      set rowcount 0
   end
end
/* Consulta opcion QUERY */
/*************************/
if @i_operacion = 'Q'
begin
    if @w_existe = 1
         select 
              @w_documento,
              @w_toperacion,
              @w_desc_toperacion,
              @w_producto,
              @w_moneda,
              @w_desc_moneda,
              @w_descripcion,
              @w_template,
              @w_mnemonico,
              @w_tipo,    --SAL 04/07/1999
              @w_dato,
              @w_medio
    else
    begin
    /*Registro no existe */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file, 
     @t_from  = @w_sp_name,
        @i_num   = 2101005
        return 1 
    end
end
return 0
GO


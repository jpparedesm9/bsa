/************************************************************************/
/*    Archivo:              pro_tran2.sp                */
/*    Stored procedure:     sp_cons_pro_transaccion            */
/*    Base de datos:        cobis                    */
/*    Producto:             Administracion                    */
/*    Disenado por:         Mauricio Bayas/Sandra Ortiz            */
/*    Fecha de escritura:   28-Nov-1992                    */
/************************************************************************/
/*                IMPORTANTE                */
/*    Este programa es parte de los paquetes bancarios propiedad de    */
/*    "COBISCORP"                        */
/*    Su uso no autorizado queda expresamente prohibido asi como    */
/*    cualquier alteracion o agregado hecho por alguno de sus        */
/*    usuarios sin el debido consentimiento por escrito de la     */
/*    Presidencia Ejecutiva de COBISCORP o su representante.        */
/************************************************************************/
/*                PROPOSITO                */
/*    Este programa procesa las transacciones de:            */
/*    Insercion de producto - transaccion                */
/*    Actualizacion del producto - transaccion            */
/*    Borrado del producto - transaccion                */
/*    Busqueda del producto - transaccion                */
/*    Query del producto - transaccion                */
/*    Ayuda del producto - transaccion                */
/************************************************************************/
/*                MODIFICACIONES                */
/*    FECHA        AUTOR        RAZON                */
/*    28/Nov/1992    L. Carvajal    Emision inicial            */
/*    07/Jun/1993    M. Davila    Search sin error        */
/*    02/Mar/1994    F.Espinosa    Query                */
/*    09/May/1994    F.Espinosa    Division del Stored Procedure    */
/*    18/04/2016     BBO           Migracion SYB-SQL FAL                */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_cons_pro_transaccion')
   drop proc sp_cons_pro_transaccion



go
create proc sp_cons_pro_transaccion (
    @s_ssn            int = NULL,
    @s_user            login = NULL,
    @s_sesn            int = NULL,
    @s_term            varchar(32) = NULL,
    @s_date            datetime = NULL,
    @s_srv            varchar(30) = NULL,
    @s_lsrv            varchar(30) = NULL, 
    @s_rol            smallint = NULL,
    @s_ofi            smallint = NULL,
    @s_org_err        char(1) = NULL,
    @s_error        int = NULL,
    @s_sev            tinyint = NULL,
    @s_msg            descripcion = NULL,
    @s_org            char(1) = NULL,
    @t_debug        char(1) = 'N',
    @t_file            varchar(14) = null,
    @t_from            varchar(32) = null,
    @t_trn            smallint =NULL,
    @i_operacion            char(1),
    @i_tipo_h        char(1)     = null,
    @i_modo            smallint    = null,
    @i_producto             tinyint     = NULL,
    @i_tipo                 char(1)     = NULL,
    @i_moneda               tinyint     = NULL,
    @i_transaccion        int    = NULL,
        @i_procedure        int    = NULL,
    @i_rol            tinyint     = NULL,
    @i_lote            char(1)     = NULL
)
as
declare
    @w_today        datetime,
    @w_sp_name        varchar(32),
    @o_siguiente        int,
    @o_nombre_p        descripcion,
    @o_nombre_m        descripcion,
    @o_nombre_t        descripcion,
    @o_transaccion        int,
    @o_des_transaccion    descripcion,
    @o_procedimiento    int,
    @o_des_procedimiento    descripcion


select @w_today = @s_date
select @w_sp_name = 'sp_cons_pro_transaccion'

/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15020
begin
     set rowcount 20
     if @i_modo = 0
     begin
        select  'Cod. Producto' = pt_producto,
        'Tipo' = pt_tipo,
                'Cod. Moneda' = pt_moneda,
        'Descripcion' = pm_descripcion,
        'Cod. transaccion' = pt_transaccion,
                'Transaccion' = tn_descripcion,
            'Cod. procedimiento' = pt_procedure,
        'Procedimiento' = pd_stored_procedure
     from    ad_pro_transaccion, cl_pro_moneda, cl_ttransaccion, ad_procedure
    where    pt_producto = pm_producto
      and    pt_moneda = pm_moneda
      and    pt_tipo = pm_tipo
          and   pt_transaccion = tn_trn_code
      and   pt_procedure = pd_procedure
          and   pt_estado = 'V'
        order   by pt_producto, pt_tipo, pt_moneda, pt_transaccion
       set rowcount 0
       return 0
     end
     if @i_modo = 1
     begin
        select 'Cod. Producto' = pt_producto,
               'Tipo' = pt_tipo,
               'Cod. Moneda' = pt_moneda,
               'Descripcion' = pm_descripcion,
               'Cod. transaccion' = pt_transaccion,
               'Transaccion' = tn_descripcion,
               'Cod. procedimiento' = pt_procedure,
               'Procedimiento' = pd_stored_procedure
          from ad_pro_transaccion                                           --inicio mig syb-sql 18042016
               inner join cl_pro_moneda on pt_producto = pm_producto
                                 and pt_moneda = pm_moneda
                                 and pt_tipo = pm_tipo
               inner join cl_ttransaccion on pt_transaccion = tn_trn_code
               left outer join ad_procedure on pt_procedure = pd_procedure
         where pt_estado = 'V'
           and ((pt_producto > @i_producto)
            or ((pt_producto = @i_producto) and (pt_tipo > @i_tipo))
            or ((pt_producto = @i_producto) and (pt_tipo = @i_tipo) and (pt_moneda > @i_moneda))
            or ((pt_producto = @i_producto) and (pt_tipo = @i_tipo) and (pt_moneda = @i_moneda) and (pt_transaccion > @i_transaccion)))
          order by pt_producto, pt_tipo, pt_moneda, pt_transaccion          --fin mig syb-sql 18042016

          /******** MIGRACION SYB-SQL FAL
         from    ad_pro_transaccion, cl_pro_moneda, cl_ttransaccion, ad_procedure
        where    pt_producto = pm_producto
          and    pt_moneda = pm_moneda
          and    pt_tipo = pm_tipo
          and    pt_transaccion = tn_trn_code
          and   pt_procedure *= pd_procedure
          and  (
                    (pt_producto > @i_producto)
              or    ((pt_producto = @i_producto) and (pt_tipo > @i_tipo))
              or    ((pt_producto = @i_producto) and (pt_tipo = @i_tipo)
            and (pt_moneda > @i_moneda))
              or    ((pt_producto = @i_producto) and (pt_tipo = @i_tipo)
            and (pt_moneda = @i_moneda) 
            and (pt_transaccion > @i_transaccion))
               )
          and   pt_estado = 'V'
        order   by pt_producto, pt_tipo, pt_moneda, pt_transaccion
        *********/
        
       set rowcount 0
       return 0
     end
     if @i_modo = 2
     begin
        select  'Cod. Producto' = pt_producto,
                'Tipo' = pt_tipo,
                'Cod. Moneda' = pt_moneda,
                'Descripcion' = substring(pm_descripcion, 1, 30),
                'Cod. procedimiento' = pt_procedure,
                'Procedimiento' = pd_stored_procedure
          from ad_pro_transaccion                                           --inicio mig syb-sql 18042016
               inner join cl_pro_moneda on pt_producto = pm_producto
                                 and pt_moneda = pm_moneda
                                 and pt_tipo = pm_tipo               
               left outer join ad_procedure on pt_procedure = pd_procedure
         where pt_estado = 'V'
		 and    pt_transaccion = @i_transaccion
         order by pt_producto, pt_tipo, pt_moneda                           --fin mig syb-sql 18042016
        
        /******  MIGRACION SYB-SQL
         from    ad_pro_transaccion, cl_pro_moneda, ad_procedure
        where    pt_producto = pm_producto
          and    pt_moneda = pm_moneda
          and    pt_tipo = pm_tipo
          and    pt_transaccion = @i_transaccion
          and   pt_procedure *= pd_procedure
          and   pt_estado = 'V'
        order    by pt_producto, pt_tipo, pt_moneda
        ********/
    
       set rowcount 0
       return 0
     end
     if @i_modo = 3
     begin
        select  'Cod. Producto' = pt_producto,
                'Tipo' = pt_tipo,
                'Cod. Moneda' = pt_moneda,
                'Descripcion' = substring(pm_descripcion, 1, 30),
                'Cod. procedimiento' = pt_procedure,
                'Procedimiento' = pd_stored_procedure
          from ad_pro_transaccion                                           --inicio mig syb-sql 18042016
               inner join cl_pro_moneda on pt_producto = pm_producto
                                 and pt_moneda = pm_moneda
                                 and pt_tipo = pm_tipo         
               left outer join ad_procedure on pt_procedure = pd_procedure
         where pt_estado = 'V'
           and pt_transaccion = @i_transaccion
           and ((pt_producto > @i_producto)
            or ((pt_producto = @i_producto) and (pt_tipo > @i_tipo))
            or ((pt_producto = @i_producto) and (pt_tipo = @i_tipo) and (pt_moneda > @i_moneda)))
         order by pt_producto, pt_tipo, pt_moneda                           --fin mig syb-sql 18042016

         /********** MIGRACION SYB-SQL FAL
         from    ad_pro_transaccion, cl_pro_moneda, ad_procedure
        where    pt_producto = pm_producto
          and    pt_moneda = pm_moneda
          and    pt_tipo = pm_tipo
          and   pt_procedure *= pd_procedure
          and    pt_transaccion = @i_transaccion
          and  (
                (pt_producto > @i_producto)
          or    ((pt_producto = @i_producto) and (pt_tipo > @i_tipo))
          or    ((pt_producto = @i_producto) and (pt_tipo = @i_tipo)
        and (pt_moneda > @i_moneda))
           )
          and   pt_estado = 'V'
        order    by pt_producto, pt_tipo, pt_moneda
        **********/
        
       set rowcount 0
       return 0
     end
    
     if @i_modo = 4
     begin
        select  'Cod.' = pt_transaccion,
                'Transaccion' = tn_descripcion,
                'Cod. procedimiento' = pt_procedure,
                'Procedimiento' = pd_stored_procedure
         --inicio migra syb-sql  
          from  ad_pro_transaccion
                inner join cl_ttransaccion on pt_transaccion = tn_trn_code
                left outer join ad_procedure on pd_procedure = pt_procedure
         where  pt_producto = @i_producto
           and  pt_moneda = @i_moneda
           and  pt_tipo = @i_tipo
           and  pt_estado = 'V'
           and  pt_transaccion NOT in (select  ta_transaccion
                                        from    ad_tr_autorizada
                                        where   ta_producto = @i_producto
                                        and     ta_tipo = @i_tipo
                                        and     ta_moneda = @i_moneda
                                        and     ta_rol = @i_rol)
        order    by pt_transaccion
         --fin migra syb-sql           
         /*******MIGRACION SYB-SQL
         from    ad_pro_transaccion, cl_ttransaccion, ad_procedure
        where    pt_producto = @i_producto
          and    pt_moneda = @i_moneda
          and    pt_tipo = @i_tipo
          and   pt_transaccion = tn_trn_code
          and   pd_procedure =* pt_procedure
          and    pt_estado = 'V'
          and    pt_transaccion NOT in (
                select  ta_transaccion
                from    ad_tr_autorizada
                where   ta_producto = @i_producto
                and     ta_tipo = @i_tipo
                and     ta_moneda = @i_moneda
                and     ta_rol = @i_rol)
        order    by pt_transaccion
        *****/
       set rowcount 0
       return 0
     end
     if @i_modo = 5
     begin
        select  'Cod.' = pt_transaccion,
                'Transaccion' = tn_descripcion,
                'Cod. procedimiento' = pt_procedure,
                'Procedimiento' = pd_stored_procedure
          from ad_pro_transaccion                                           --inicio mig syb-sql 18042016
               inner join cl_ttransaccion on pt_transaccion = tn_trn_code
               left outer join ad_procedure on pt_procedure = pd_procedure
         where pt_producto    = @i_producto
           and pt_moneda      = @i_moneda
           and pt_tipo        = @i_tipo
           and pt_transaccion > @i_transaccion
           and pt_estado      = 'V'
           and pt_transaccion NOT in ( select  ta_transaccion
                                        from    ad_tr_autorizada
                                        where   ta_producto = @i_producto
                                        and     ta_tipo = @i_tipo
                                        and     ta_moneda = @i_moneda
                                        and     ta_rol = @i_rol)
         order by pt_transaccion                                             --fin mig syb-sql 18042016
        
        /******* MIGRACION SYB-SQL
         from    ad_pro_transaccion, cl_ttransaccion, ad_procedure
        where    pt_producto = @i_producto
          and    pt_moneda = @i_moneda
          and    pt_tipo = @i_tipo
          and    pt_transaccion = tn_trn_code
          and    pt_procedure *= pd_procedure
          and    pt_transaccion > @i_transaccion
          and    pt_estado = 'V'
          and    pt_transaccion NOT in (
                select  ta_transaccion
                from    ad_tr_autorizada
                where   ta_producto = @i_producto
                and     ta_tipo = @i_tipo
                and     ta_moneda = @i_moneda
                and     ta_rol = @i_rol)
        order    by pt_transaccion
        ********/
        
       set rowcount 0
       return 0
     end
     if @i_modo = 6
     begin
        select  'Cod. transaccion' = pt_transaccion,
                'Transaccion' = substring(tn_descripcion,1,40),
                'Cod. Producto' = pt_producto,
                'Tipo' = pt_tipo,
                'Cod. Moneda' = pt_moneda,
                'Descripcion' = pm_descripcion
          from  ad_pro_transaccion                                      --inicio mig syb-sql 18042016
                inner join cl_pro_moneda on pt_producto = pm_producto
                                  and pt_moneda   = pm_moneda
                                  and pt_tipo     = pm_tipo
                inner join cl_ttransaccion on pt_transaccion = tn_trn_code
                left outer join ad_procedure on pt_procedure = pd_procedure
          where pt_estado = 'V'
            and pt_procedure = @i_procedure
          order by pt_transaccion, pt_producto, pt_tipo, pt_moneda       --fin mig syb-sql 18042016

          /******* MIGRACION SYB-SQL
         from    ad_pro_transaccion, cl_pro_moneda, cl_ttransaccion, ad_procedure
        where    pt_producto = pm_producto
          and    pt_moneda = pm_moneda
          and    pt_tipo = pm_tipo
          and   pt_transaccion = tn_trn_code
          and   pt_procedure *= pd_procedure
          and   pt_estado = 'V'
          and   pt_procedure = @i_procedure
        order   by pt_transaccion, pt_producto, pt_tipo, pt_moneda 
        *******/
        
       set rowcount 0
       return 0
     end
     if @i_modo = 7
     begin
        select  'Cod. transaccion' = pt_transaccion,
                'Transaccion'      = substring(tn_descripcion,1,40),
                'Cod. Producto'    = pt_producto,
                'Tipo'             = pt_tipo,
                'Cod. Moneda'      = pt_moneda,
                'Descripcion'      = pm_descripcion
          from  ad_pro_transaccion                                      --inicio mig syb-sql 18042016
                inner join cl_pro_moneda on pt_producto = pm_producto
                                  and pt_moneda   = pm_moneda
                                  and pt_tipo     = pm_tipo
                inner join cl_ttransaccion on pt_transaccion = tn_trn_code
                left outer join ad_procedure on pt_procedure = pd_procedure
          where pt_estado = 'V'
            and pt_procedure = @i_procedure
            and ((pt_transaccion > @i_transaccion)
             or ((pt_transaccion = @i_transaccion) and (pt_producto > @i_producto))
             or ((pt_transaccion = @i_transaccion) and (pt_producto = @i_producto) and (pt_tipo > @i_tipo))
             or ((pt_transaccion = @i_transaccion) and (pt_producto = @i_producto) and (pt_tipo = @i_tipo) and (pt_moneda > @i_moneda)))
          order by pt_transaccion, pt_producto, pt_tipo, pt_moneda       --fin mig syb-sql 18042016
                
        /******** MIGRACION SYB-SQL        
         from    ad_pro_transaccion, cl_pro_moneda, cl_ttransaccion, ad_procedure
        where    pt_producto = pm_producto
          and    pt_moneda = pm_moneda
          and    pt_tipo = pm_tipo
          and    pt_transaccion = tn_trn_code
          and   pt_procedure *= pd_procedure
          and   pt_procedure = @i_procedure
         and  (
                (pt_transaccion > @i_transaccion)
          or    ((pt_transaccion = @i_transaccion) and (pt_producto
                  > @i_producto))
          or    ((pt_transaccion = @i_transaccion) and (pt_producto 
                  = @i_producto) and (pt_tipo > @i_tipo))
          or    ((pt_transaccion = @i_transaccion) and (pt_producto 
                  = @i_producto) and (pt_tipo = @i_tipo)
          and (pt_moneda > @i_moneda))                )
          and   pt_estado = 'V'
        order   by pt_transaccion, pt_producto, pt_tipo, pt_moneda
        ********/
        
       set rowcount 0
       return 0
     end
     

    /* Busqueda de Transacciones dadas un Producto (modo 8 y 9)*/ 
     if @i_modo = 8
     begin
    select    'Cod. transaccion' = pt_transaccion,
                'Transaccion' = substring(tn_descripcion, 1, 40),
        'Cod. procedimiento' = pt_procedure,
        'Procedimiento' = pd_stored_procedure
     from    ad_pro_transaccion, cl_ttransaccion, ad_procedure
    where    pt_producto = @i_producto
      and    pt_moneda = @i_moneda
      and    pt_tipo = @i_tipo
          and   pt_transaccion = tn_trn_code
          and   pd_procedure = pt_procedure
      and    pt_estado = 'V'
    order    by pt_transaccion
       set rowcount 0
       return 0
     end
     if @i_modo = 9
     begin
    select    'Cod. transaccion' = pt_transaccion,
                'Transaccion' = substring(tn_descripcion, 1, 40),
        'Cod. procedimiento' = pt_procedure,
        'Procedimiento' = pd_stored_procedure
     from    ad_pro_transaccion, cl_ttransaccion, ad_procedure
    where    pt_producto = @i_producto
      and    pt_moneda = @i_moneda
      and    pt_tipo = @i_tipo
      and    pt_transaccion = tn_trn_code
      and    pt_procedure = pd_procedure
      and    pt_transaccion > @i_transaccion
      and    pt_estado = 'V'
    order    by pt_transaccion
       set rowcount 0
       return 0
     end
end
else
begin
    exec sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end

/* ** help ** */
if @i_operacion = 'H'
begin
If @t_trn = 15021
begin
 if @i_tipo_h = 'A'
 begin
     select   pt_transaccion, substring(tn_descripcion,1,20)
       from   ad_pro_transaccion, cl_ttransaccion
          where   pt_transaccion = tn_trn_code
        and   pt_producto = @i_producto
        and   pt_moneda = @i_moneda
        and   pt_tipo = @i_tipo
            and   pt_estado = 'V'  
       order  by pt_transaccion
 end
 if @i_tipo_h = 'V'
 begin
    select substring(tn_descripcion,1,20)
      from ad_pro_transaccion, cl_ttransaccion
     where pt_transaccion = tn_trn_code
       and pt_transaccion = @i_transaccion
       and pt_producto = @i_producto
       and pt_tipo = @i_tipo
       and pt_moneda = @i_moneda
       and pt_estado = 'V' 
    if @@rowcount = 0
    begin
       exec sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 1510110
       /*  'No existe producto transaccion' */
      return 1
    end
 end
 return 0
end
else
begin
    exec sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15022
begin
    select @o_transaccion       = pt_transaccion,
           @o_des_transaccion   = tn_descripcion,
           @o_procedimiento     = pt_procedure,
           @o_des_procedimiento = pd_stored_procedure
      from ad_pro_transaccion                                           --inicio mig syb-sql 18042016
           inner join cl_ttransaccion on pt_transaccion = tn_trn_code
           left outer join ad_procedure on pt_procedure = pd_procedure
     where pt_producto    = @i_producto
       and pt_moneda      = @i_moneda
       and pt_tipo        = @i_tipo
       and pt_transaccion = @i_transaccion
       and pt_estado      = 'V'                                         --fin mig syb-sql 18042016
     
     /****** MIGRACION SYB-SQL
     from    ad_pro_transaccion, cl_ttransaccion, ad_procedure
    where    pt_producto = @i_producto
      and    pt_moneda = @i_moneda
      and    pt_tipo = @i_tipo
      and    pt_transaccion = tn_trn_code
      and    pt_procedure *= pd_procedure
      and    pt_transaccion = @i_transaccion
      and    pt_estado = 'V'
        ********/
        
      if @@rowcount = 0
        begin
        exec sp_cerror
           @t_debug     = @t_debug,
           @t_file     = @t_file,
           @t_from     = @w_sp_name,
           @i_num     = 151011
           /*  'No existe producto transaccion' */
        return 1
        end
      select @o_transaccion, @o_des_transaccion, @o_procedimiento,
         @o_des_procedimiento    
return 0
end
else
begin
    exec sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end
go

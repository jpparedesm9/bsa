/****************************************************************************/
/*     Archivo:     perango.sp                                              */
/*     Stored procedure: sp_rango_pe                                        */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:                                                        */
/*     Fecha de escritura: 01-Ene-1994                                      */
/****************************************************************************/
/*                            IMPORTANTE                                    */
/*    Esta aplicacion es parte de los paquetes bancarios propiedad          */
/*    de COBISCorp.                                                         */
/*    Su uso no    autorizado queda  expresamente   prohibido asi como      */
/*    cualquier    alteracion o  agregado  hecho por    alguno  de sus      */
/*    usuarios sin el debido consentimiento por   escrito de COBISCorp.     */
/*    Este programa esta protegido por la ley de   derechos de autor        */
/*    y por las    convenciones  internacionales   de  propiedad inte-      */
/*    lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para   */
/*    obtener ordenes  de secuestro o  retencion y para  perseguir          */
/*    penalmente a los autores de cualquier   infraccion.                   */
/****************************************************************************/
/*                           PROPOSITO                                      */
/*     Este programa inserta/elimina/actualiza/consulta de productos        */
/*     bancarios.                                                           */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*      30/Sep/2003     Gloria Rueda    Retornar c¢digos de error           */
/*     05/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select * from sysobjects where name = 'sp_rango_pe')
drop proc sp_rango_pe
go

create proc sp_rango_pe (
    @s_ssn          int,
    @s_srv          varchar(30) = null,
    @s_lsrv         varchar(30) = null,
    @s_user         varchar(30) = null,
    @s_sesn         int,
    @s_term         varchar(10),
    @s_date         datetime,
    @s_org          char(1),
    @s_ofi          smallint,
    @s_rol          smallint,
    @s_org_err      char(1)=null,
    @s_error        int = null,
    @s_sev          tinyint = null,
    @s_msg          mensaje = null,
    @t_debug        char(1) = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(32) = null,
    @t_rty          char(1) = 'N',
    @t_trn          smallint,
    @t_show_version     bit     = 0,
    @i_operacion        char(1),
    @i_modo             tinyint=null,
    @i_tipo_rango       smallint=null,
    @i_moneda       tinyint = null,
    @i_grupo_rango      smallint = null,
    @i_rango            tinyint = null,
    @i_desde            money=null,
    @i_hasta            money=null,
    @i_estado           char(1)=null,
    @o_rango        tinyint= null out
)
as
declare @w_sp_name varchar(32),
    @w_return  int,
    @w_secuencial  tinyint,
    @w_desde  money,
    @w_hasta  money,
    @w_maxhasta money,
    @w_decimal char(1),
    @w_no_decimal tinyint

select @w_sp_name = 'sp_rango_pe' ,
       @w_decimal = 'N',
       @w_no_decimal = 0
       
if @t_show_version = 1
begin
    print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
    return 0
end

if @t_debug = 'S'
begin
    exec cobis..sp_begin_debug @t_file=@t_file
      select '/**Store Procedure**/' = @w_sp_name,
    s_ssn           = @s_ssn,
    s_user      = @s_user,
    s_term      = @s_term,
    s_date      = @s_date,
    s_srv       = @s_srv,
    s_lsrv      = @s_lsrv,
    s_ofi       = @s_ofi,
    t_file      = @t_file,
    t_from      = @t_from,
    i_operacion     = @i_operacion,
    i_modo      = @i_modo,
    i_tipo_rango    = @i_tipo_rango,
    i_rango         = @i_rango,
    i_desde         = @i_desde,
        i_hasta         = @i_hasta,
    i_estado    = @i_estado
    exec cobis..sp_end_debug
end

if @i_operacion in ('I','U')
begin
     select @w_decimal = mo_decimales from cobis..cl_moneda
       where mo_moneda = @i_moneda

     if @w_decimal = 'S'
     begin
        select @w_no_decimal = pa_tinyint from cobis..cl_parametro
          where pa_nemonico = 'DCI'
     end

     select @w_desde = round(@i_desde,@w_no_decimal),
        @w_hasta = round(@i_hasta,@w_no_decimal)
     if @w_desde > @w_hasta
     begin
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 351516,
        @i_msg      = 'VALOR HASTA DEBE SER MAYOR A VALOR DESDE'
    return 351516
     end
end

if @i_operacion = 'I'
begin
    /* Validaciones */
    if @t_trn != 4035
    begin
       /* Error en codigo de transaccion */
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 351516
    return 351516
    end
    if not exists (select * from pe_tipo_rango
                    where tr_tipo_rango = @i_tipo_rango)
    begin
        /* No existe tipo de rango  */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351507
        return 351507
   end

   if exists (select * from pe_tipo_rango
                where tr_tipo_rango = @i_tipo_rango
                  and tr_estado = 'N')
   begin
       /* Tipo de Rango no esta vigente */
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351506
        return 351506
    end

    if @i_estado not in ('V','N')
     begin
        /* Estado no esta definido */
         exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
              @i_num   = 351500
         return 351500
     end
	 
	 if exists (select 1 from pe_rango
          where ra_tipo_rango = @i_tipo_rango
            and ra_grupo_rango = @i_grupo_rango
            and ra_desde = @w_desde 
            and ra_hasta = @w_hasta )
     begin
        /* Rango inferior invalido */
         exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
                 @i_num   = 351555                  
         return 351555
     end

     if exists (select 1 from pe_rango
          where ra_tipo_rango = @i_tipo_rango
            and ra_grupo_rango = @i_grupo_rango
            and @w_desde >= ra_desde
            and @w_desde < ra_hasta)
     begin
        /* Rango inferior invalido */
         exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
                 @i_num   = 351555                  
         return 351555
     end
	 
     /*Encontramos el secuencial para tabla de rango       */
     if not exists (select * from pe_rango    
      	             where ra_tipo_rango = @i_tipo_rango
		       and ra_grupo_rango = @i_grupo_rango)
         select @w_secuencial = 0
     else
	begin
	  select @w_secuencial = max(ra_rango)
	    from pe_rango
	   where ra_tipo_rango = @i_tipo_rango
	     and ra_grupo_rango = @i_grupo_rango
	end

   if @w_secuencial != 0
   begin
     select @w_maxhasta = round(max(ra_hasta),@w_no_decimal)
       from pe_rango
       where ra_tipo_rango = @i_tipo_rango
     and ra_grupo_rango = @i_grupo_rango

     /* if ((@w_desde - @w_maxhasta)*(power(10,@w_no_decimal))) != 1 */
     if (@w_desde - @w_maxhasta) != 0
     begin
        /* Rango inferior no continuo */
         exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
              @i_num   = 351556
         return 351556
     end
   end

    begin tran

    select @w_secuencial = @w_secuencial + 1

      /*Insertar un nuevo rango    */
         insert into pe_rango
        (ra_tipo_rango, ra_grupo_rango, ra_rango,
             ra_desde, ra_hasta, ra_estado)
         values (@i_tipo_rango, @i_grupo_rango, @w_secuencial,
             @w_desde, @w_hasta, @i_estado)

      /*Ocurrio un error en la insercion de rango*/
      if @@error !=0
         begin
            exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
            @i_num   = 353503
           return 353503
         end
commit tran

/*Retorna el nuevo codigo del rango   */
select @o_rango = @w_secuencial
select @o_rango
return 0
end

/* Actualiza */
if @i_operacion = 'D'
begin
    /* Validaciones */
    if @t_trn != 4036
    begin
       /* Error en codigo de transaccion */
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 351516
    return 351516
    end
    if not exists (select * from pe_rango
                    where ra_tipo_rango = @i_tipo_rango
              and ra_grupo_rango = @i_grupo_rango
              and ra_rango      = @i_rango )
    begin
        /* No existe rango  */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 351530
        return 351530
   end

    begin tran

         delete pe_rango
          where ra_tipo_rango  = @i_tipo_rango
        and ra_grupo_rango = @i_grupo_rango
            and ra_rango       = @i_rango

      /*Ocurrio un error en la eliminacion de rango*/
      if @@error !=0
         begin
            exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
            @i_num   = 355508
           return 355508
           end
commit tran
return 0
end

/* Consulta */
if @i_operacion = 'S'
begin
    if @t_trn != 4037
    begin
       /* Error en codigo de transaccion */
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file     = @t_file,
        @t_from     = @w_sp_name,
        @i_num      = 351516
    return 351516
    end
    set rowcount 15

	 select	 '1678'       = ra_rango,             --RANGO
             '1213'       = ra_desde,             --DESDE
             '1398'       = ra_hasta,             --HASTA
	         '1333'       = ra_estado             --ESTADO
          from   pe_rango
          where  ra_tipo_rango = @i_tipo_rango
	    and  ra_grupo_rango = @i_grupo_rango
	    and  ra_rango > @i_rango
          order  by ra_rango   

   set rowcount 0
   return 0
end
go



/************************************************************************/
/*	Archivo: 		conspygt.sp                             */
/*	Stored procedure: 	sp_man_tran                             */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               Contabilidad                            */
/*	Disenado por:           José Molano                             */
/*	Fecha de escritura:     Abr-18-2007                             */
/************************************************************************/
/*				IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de la "NCR  */
/*	CORPORATION".                                                   */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus         */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*				PROPOSITO                               */
/*	     store procedure de consulta del manual transaccional       */
/************************************************************************/
/*				MODIFICACIONES                          */
/*	FECHA		AUTOR			RAZON                   */
/*	                                                                */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_man_tran')
	drop proc sp_man_tran
go

create proc sp_man_tran
(
	    @s_ssn			    int = null,
	    @s_date			    datetime = null,
	    @s_user			    login = null,
	    @s_term			    descripcion = null,
	    @s_corr			    char(1) = null,
	    @s_ssn_corr		    int = null,
        @s_ofi			    smallint = null,
	    @t_rty			    char(1) = null,
        @t_trn			    smallint = null,
	    @t_debug		    char(1) = 'N',
	    @t_file			    varchar(14) = null,
	    @t_from			    varchar(30) = null,
        @i_empresa          tinyint       = null,
        @i_producto         smallint      = null,
        @i_perfil           varchar(20)   = null,
        @i_cuenta           varchar(14)   = null,
        @i_area             varchar(10)   = null,
        @i_debcred          char(1)       = null,
        @i_operacion        char(1),
        @i_modo             tinyint       = null,
        @i_secuencial       int           = null
)
as
declare 
	@w_return	    int,		/* valor que retorna */
	@w_sp_name	    varchar(32),
	@w_nombre       varchar(50),
	@w_movimiento   char(1),
	@w_estado       char(1),
	@w_disp_gnral   varchar(255),
	@w_existe       tinyint,
    @w_descripcion  descripcion	
	
select @w_sp_name = 'sp_man_tran'	

if (@t_trn <> 6312 and @i_operacion = 'Q') or
   (@t_trn <> 6312 and @i_operacion = 'C') or
   (@t_trn <> 6313 and @i_operacion = 'X') or
   (@t_trn <> 6313 and @i_operacion = 'Y') or
   (@t_trn <> 6313 and @i_operacion = 'K') or
   (@t_trn <> 6313 and @i_operacion = 'S') or
   (@t_trn <> 6322 and @i_operacion = 'D') or
   (@t_trn <> 6312 and @i_operacion = 'H')

begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

if @i_operacion = 'H'
begin
   select @w_descripcion = pe_descripcion
   from  cob_conta..cb_perfil
   where pe_empresa  = @i_empresa 
   and   pe_producto = @i_producto 
   and   pe_perfil   = @i_perfil

   if @@rowcount > 0
      select @w_existe = 1
   else
      select @w_existe = 0
      
   set rowcount 20
   if @i_modo = 0
   begin
      if @w_existe = 1
      begin
         select @i_producto, @i_perfil, @w_descripcion
         select 'Asto.'      = dp_asiento,
                'Area'       = dp_area,
                'Codigo'     = dp_cuenta, 
                'Cod. Valor' = dp_codval, 
                'D/C'        = dp_debcred, 
                'Constant.'  = dp_constante,
                'Orig/Dest'  = dp_origen_dest,
                'Fuente'     = dp_fuente,
                'Tip.Tran'   = dp_tipo_tran
         from  cob_conta..cb_det_perfil
         where dp_empresa  = @i_empresa
         and   dp_producto = @i_producto
         and   dp_perfil   = @i_perfil
         order by dp_asiento
         if @@rowcount = 0
         begin
            /*Registro no existe */
            exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file, 
               @t_from  = @w_sp_name,
               @i_num   = 601153
            return 1 
         end
      end
      else
      begin
         /*Registro no existe */
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601153
         return 1 
      end
   end
   else
   begin
      select dp_asiento,
             dp_area,
             dp_cuenta, 
             dp_codval, 
             dp_debcred, 
             dp_constante,
             dp_origen_dest,
             dp_fuente,
             dp_tipo_tran
      from   cob_conta..cb_det_perfil
      where  dp_empresa  = @i_empresa
      and    dp_producto = @i_producto
      and    dp_perfil   = @i_perfil
      and    dp_asiento  > @i_secuencial
      order by dp_asiento

      if @@rowcount = 0 
      begin
         /*No existen mas registros*/
         exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 601150
         return 1 
      end
   end
   return 0 
end

/*********************/

if @i_operacion = 'Q'
begin
     if @i_modo = 0
     begin
          set rowcount 15
          select 'PERFIL'      = cp_perfil,
                 'DESCRIPCION' = cp_descripcion,
                 'CUENTA'      = cp_cuenta,
                 'NOM. CUENTA' = cp_nomcta,
                 'AREA'        = cp_area,
                 'NATURALEZA'  = cp_debcred,
                 'MODULO'      = cp_producto,
                 cp_secuencial
          from cob_conta..cb_cuenperfi
          where (cp_producto = @i_producto or @i_producto is null)
          and  (cp_cuenta  = @i_cuenta or @i_cuenta is null)     
          and  (cp_perfil  = @i_perfil or @i_perfil is null) 
          and  (cp_area  = @i_area or @i_area is null) 
          and  (cp_debcred  = @i_debcred or @i_debcred is null) 
          and  cp_secuencial > @i_secuencial    
          order by cp_secuencial, cp_perfil

     end
     
     if @i_modo = 1
     begin
          set rowcount 15
          
          select 'PERFIL'      = cp_perfil,
                 'DESCRIPCION' = cp_descripcion,
                 'CUENTA'      = cp_cuenta,
                 'NOM. CUENTA' = cp_nomcta,
                 'AREA'        = cp_area,
                 'NATURALEZA'  = cp_debcred,
                 'MODULO'      = cp_producto,
                 cp_secuencial
          from cob_conta..cb_cuenperfi
          where (cp_producto = @i_producto or @i_producto is null)
          and  (cp_cuenta  = @i_cuenta or @i_cuenta is null)     
          and  (cp_perfil  = @i_perfil or @i_perfil is null) 
          and  (cp_area  = @i_area or @i_area is null) 
          and  (cp_debcred  = @i_debcred or @i_debcred is null) 
          and  cp_secuencial > @i_secuencial    
          order by cp_secuencial, cp_perfil
     end
end

if @i_operacion = 'C'
begin
     if @i_modo = 0
     begin
          set rowcount 15
          select 'PERFIL'      = cp_perfil,
                 'DESCRIPCION' = cp_descripcion,
                 'CUENTA'      = cp_cuenta,
                 'NOM. CUENTA' = cp_nomcta,
                 'AREA'        = cp_area,
                 'NATURALEZA'  = cp_debcred,
                 'MODULO'      = cp_producto,
                 cp_secuencial
          from cob_conta..cb_cuenperfi
          where cp_perfil > ''
          and   cp_cuenta = @i_cuenta
          and  (cp_debcred  = @i_debcred or @i_debcred is null) 
          and  (cp_producto = @i_producto or @i_producto is null)
          and  (cp_area = @i_area or @i_area is null)                    
          order by cp_secuencial, cp_perfil
     end
     if @i_modo = 1
     begin
          set rowcount 15
          select 'PERFIL'      = cp_perfil,
                 'DESCRIPCION' = cp_descripcion,
                 'CUENTA'      = cp_cuenta,
                 'NOM. CUENTA' = cp_nomcta,
                 'AREA'        = cp_area,
                 'NATURALEZA'  = cp_debcred,
                 'MODULO'      = cp_producto,
                 cp_secuencial
          from cob_conta..cb_cuenperfi
          where cp_perfil > ''
          and   cp_cuenta = @i_cuenta
          and  (cp_debcred  = @i_debcred or @i_debcred is null) 
          and  (cp_producto = @i_producto or @i_producto is null)
          and  (cp_area = @i_area or @i_area is null)                    
          and   cp_secuencial > @i_secuencial
          order by cp_secuencial, cp_perfil
     end
end

if @i_operacion = 'S'
begin
     if @i_modo = 0
     begin
          set rowcount 15
          select 'PERFIL'      = nc_perfil,
                 'DESCRIPCION' = nc_descripcion,
                 'CUENTA'      = nc_cuenta,
                 'NOM. CUENTA' = nc_descripcta,
                 'AREA'        = nc_area,
                 'NATURALEZA'  = nc_debcred,
                 'MODULO'      = nc_producto,
                 nc_secuencial
          from cob_conta..cb_perfil_nocobis
          where nc_producto = @i_producto
          and  (nc_cuenta  = @i_cuenta or @i_cuenta is null)     
          and  (nc_perfil  = @i_perfil or @i_perfil is null) 
          and  (nc_area  = @i_area or @i_area is null) 
          and  (nc_debcred  = @i_debcred or @i_debcred is null) 
          and  nc_secuencial > @i_secuencial    
          order by nc_secuencial, nc_perfil

     end
     
     if @i_modo = 1
     begin
          set rowcount 15
          
          select 'PERFIL'      = nc_perfil,
                 'DESCRIPCION' = nc_descripcion,
                 'CUENTA'      = nc_cuenta,
                 'NOM. CUENTA' = nc_descripcta,
                 'AREA'        = nc_area,
                 'NATURALEZA'  = nc_debcred,
                 'MODULO'      = nc_producto,
                 nc_secuencial
          from cob_conta..cb_perfil_nocobis
          where nc_producto = @i_producto
          and  (nc_cuenta  = @i_cuenta or @i_cuenta is null)     
          and  (nc_perfil  = @i_perfil or @i_perfil is null) 
          and  (nc_area  = @i_area or @i_area is null) 
          and  (nc_debcred  = @i_debcred or @i_debcred is null) 
          and  nc_secuencial > @i_secuencial    
          order by nc_secuencial, nc_perfil
     end
end

if @i_operacion = 'K'
begin
     if @i_modo = 0
     begin
          set rowcount 15
          select 'PERFIL'      = nc_perfil,
                 'DESCRIPCION' = nc_descripcion,
                 'CUENTA'      = nc_cuenta,
                 'NOM. CUENTA' = nc_descripcta,
                 'AREA'        = nc_area,
                 'NATURALEZA'  = nc_debcred,
                 'MODULO'      = nc_producto,
                 nc_secuencial
          from cob_conta..cb_perfil_nocobis
          where nc_perfil > ''
          and   nc_cuenta = @i_cuenta
          and  (nc_producto = @i_producto or @i_producto is null)          
          and  (nc_debcred  = @i_debcred or @i_debcred is null)
          order by nc_secuencial, nc_perfil
     end
     if @i_modo = 1
     begin
          set rowcount 15
          select 'PERFIL'      = nc_perfil,
                 'DESCRIPCION' = nc_descripcion,
                 'CUENTA'      = nc_cuenta,
                 'NOM. CUENTA' = nc_descripcta,
                 'AREA'        = nc_area,
                 'NATURALEZA'  = nc_debcred,
                 'MODULO'      = nc_producto,
                 nc_secuencial
          from cob_conta..cb_perfil_nocobis
          where nc_perfil > ''
          and   nc_cuenta = @i_cuenta
          and  (nc_producto = @i_producto or @i_producto is null)          
          and  (nc_debcred  = @i_debcred or @i_debcred is null) 
          and   nc_secuencial > @i_secuencial
          order by nc_secuencial, nc_perfil
     end
end

if @i_operacion = 'X'
begin
     select 'PRODUCTO' = codigo,
            'CODIGO'   = convert(varchar(15),valor),
            'ESTADO'   = estado
     from cobis..cl_catalogo
     where tabla in (select codigo 
                    from cobis..cl_tabla
                    where tabla = 'cb_producto_nocobis')
end

if @i_operacion = 'Y'
begin
     select codigo
     from cobis..cl_catalogo
     where tabla in (select codigo 
                    from cobis..cl_tabla
                    where tabla = 'cb_producto_nocobis')
     and valor = convert(varchar(3),@i_producto)
end

if @i_operacion = 'D'
begin
     if @i_modo = 0
     begin
          select @w_nombre     = cu_nombre,
                 @w_movimiento = cu_movimiento,
                 @w_estado     = cu_estado
          from cob_conta..cb_cuenta
          where cu_empresa = @i_empresa
          and   cu_cuenta  = @i_cuenta
          
          select @w_disp_gnral = di_texto
          from cob_conta..cb_dinamica
          where di_empresa = @i_empresa
          and   di_cuenta = @i_cuenta
          and   di_secuencial = 0
          and   di_tipo_dinamica = @i_debcred          
          
          select @w_nombre
          select @w_movimiento
          select @w_estado
          select @w_disp_gnral
          
          set rowcount 10
          select 'TEXTO'      = di_texto, 
                 'DISP_LEGAL' = di_disp_legal,
                 'SECUENCIAL' = di_secuencial
          from cob_conta..cb_dinamica
          where di_empresa = @i_empresa
          and   di_cuenta = @i_cuenta
          and   di_secuencial > 0
          and   di_tipo_dinamica = @i_debcred
          order by di_secuencial 
     end
     if @i_modo = 1
     begin
          set rowcount 10
          select 'TEXTO'      = di_texto, 
                 'DISP_LEGAL' = di_disp_legal,
                 'SECUENCIAL' = di_secuencial
          from cob_conta..cb_dinamica
          where di_empresa = @i_empresa
          and   di_cuenta = @i_cuenta
          and   di_secuencial  > @i_secuencial
          and   di_tipo_dinamica = @i_debcred
          order by di_secuencial
     end
end      

go
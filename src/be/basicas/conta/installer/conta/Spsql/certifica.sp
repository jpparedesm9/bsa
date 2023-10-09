/************************************************************************/
/*          Archivo:             certica.sp                             */
/*          Stored procedure:    sp_certificados                        */
/*          Base de datos:       cob_conta               				*/
/*          Producto:            contabilidad                      		*/
/*          Disenado por:        .                                  	*/
/*          Fecha de escritura:  Mayo/2008                              */
/************************************************************************/
/*                            IMPORTANTE				                */
/*     Este programa es parte de los paquetes bancarios propiedad de    */
/*     "MACOSA", representantes exclusivos para el Ecuador de           */
/*     "MACOSA".                                                        */
/*     Su uso no autorizado queda expresamente prohibido asi como	    */
/*     cualquier alteracion o agregado hecho por alguno de sus		    */
/*     usuarios sin el debido consentimiento por escrito de la 	        */
/*     Presidencia Ejecutiva de MACOSA o su representante.		        */
/************************************************************************/
/*                              PROPOSITO				                */
/*    Extrae información para certificados IVA, ICA, Rete fuentes       */
/*    de tabla de contabilidad.                                         */
/************************************************************************/
/*                            MODIFICACIONES			             	*/
/*             FECHA		AUTOR		RAZON			             	*/
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_certificados' and xtype = 'P')
    drop proc sp_certificados
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create procedure sp_certificados
(
    @i_periodo    smallint  = null,
    @i_bimestre   tinyint   = null,
    @i_operacion  char(1)   = null,
    @i_fecha_i    datetime  = null,
    @i_fecha_f    datetime  = null,
    @i_ciudad     int       = null,
    @i_empresa    tinyint   = 1,
    @i_impuesto   char(1) 

)
as
declare @w_fecha     varchar(10),
        @w_fecha_ini datetime,
        @w_fecha_fin datetime

if @i_operacion in ('K','G')
begin
    if (@i_bimestre > 6) or (@i_bimestre < 0)
    begin
       print 'Bimestre debe estar en el rango 0 - 6'
       return 1
    end
    
    select @i_bimestre = @i_bimestre * 2
    
    select @w_fecha = '01/01/'+convert(varchar(4), @i_periodo)
    
    select @w_fecha_fin = convert(datetime,(dateadd(dd, -1,(dateadd(mm, @i_bimestre, @w_fecha)))))
    
    select @w_fecha_ini = convert(datetime,(dateadd(mm, -2, dateadd(dd,1,@w_fecha_fin))))
    
    if @i_bimestre = 0
    begin
        select @w_fecha_ini = '01/01/'+convert(varchar(4), @i_periodo)
        select @w_fecha_fin = '12/31/'+convert(varchar(4), @i_periodo)
    end
    
    print @w_fecha_ini
    print @w_fecha_fin
end

if @i_operacion = 'K' --- Consulta para certificado de Retencion de IVA 
begin
    select codigo
    into #codigos
    from cobis..cl_catalogo
    where tabla = (select codigo
                   from cobis..cl_tabla
                   where tabla = 'cb_concepto_iva')

    -- Obtiene datos desde los asientos contables
    insert into cob_conta..cb_certiva_tmp( ct_cliente,    ct_oficina,    ct_concepto,   
                                           ct_comprob,    ct_fecha,      ct_valant_iva, 
                                           ct_val_iva,    ct_porc_iva,   ct_ret_iva,    
                                           ct_fecha_nxt,  ct_asiento_nxt,ct_bimestre,   
                                           ct_rangoBmt,   ct_impuesto)   
    select
        sa_ente,
        of_oficina,                                                                                                                                                                  
        iva_codigo,                                                                                                                                                             
        sa_comprobante,
        convert(varchar,sa_fecha_tran,103),	                                                                                                                                        
        convert(money,round(sa_valor_iva * 100/iva_des_porcen,0)),                                                                                                                   
        round(sa_valor_iva,0),                                                                                                                                                       
        iva_porcentaje,
        round(sa_iva_retenido,0),                                                                                                                                                    
        convert(varchar(10),sa_fecha_tran,101),                                                                                                                                      
        sa_asiento,                                                                                                                                                                  
        convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2)),                                                                                                           
        convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),103),
        @i_impuesto                                 
    from cob_conta_tercero..ct_sasiento,
         cob_conta_tercero..ct_scomprobante,
	     cob_conta..cb_iva,
         cob_conta..cb_oficina,
         cobis..cl_producto,
         #codigos
    where sa_fecha_tran >= @w_fecha_ini
      and sa_fecha_tran <= @w_fecha_fin
      and sa_mayorizado  = 'S'
      and sa_ente        > 0
      and sa_empresa     = @i_empresa
      and sa_debcred     = '1'
      and sc_producto    = sa_producto 
      and sc_fecha_tran  = sa_fecha_tran
      and sc_comprobante = sa_comprobante
      and sc_empresa     = sa_empresa
      and iva_empresa    = sa_empresa
      and iva_codigo     = sa_con_iva
      and iva_debcred    = 'D'
      and iva_codigo     = codigo
      and pd_producto    = sa_producto
      and of_empresa     = sa_empresa
      and of_oficina     = sc_oficina_orig
    order by sa_ente, sa_fecha_tran, sa_comprobante, sa_asiento         
end


if @i_operacion = 'G' -- Consulta Retencion en la fuente
begin                   

        insert into cob_conta..cb_certiva_tmp (ct_cliente,       ct_oficina,    ct_concepto,     
                                               ct_comprob,    ct_fecha,        ct_valant_iva,
                                               ct_val_iva,    ct_porc_iva,     ct_fecha_nxt,
                                               ct_compr_nxt,  ct_asiento_nxt,  ct_impuesto)  
        select sa_ente,      of_oficina,           cr_codigo,                         
               convert(varchar(12),sa_producto)+'/'+convert(varchar(12),sc_comp_definit), 
                                   convert(varchar,sa_fecha_tran,103),	round(sa_base,0),
               ((sa_valret * 100)/sa_base),     round(sa_valret,0),             convert(varchar(10),sa_fecha_tran,101),
               sa_comprobante,                  sa_asiento,              @i_impuesto
        from cob_conta_tercero..ct_sasiento,
             cob_conta_tercero..ct_scomprobante,
	     cob_conta..cb_conc_retencion,
     	     cob_conta..cb_oficina,
             cobis..cl_producto
        where sa_fecha_tran >= @w_fecha_ini
          and sa_fecha_tran <= @w_fecha_fin
          and sa_mayorizado  = 'S'
          and sa_ente        > 0
          and sa_debcred     = '2' 
	  and sc_producto    = sa_producto
          and sc_fecha_tran  = sa_fecha_tran
          and sc_comprobante = sa_comprobante
          and sc_empresa     = sa_empresa
          and cr_empresa     = @i_empresa   
          and cr_codigo      = sa_con_rete
          and cr_debcred     = 'C'
          and cr_tipo        = 'R'
          and pd_producto    = sa_producto
          and of_oficina     = sa_oficina_dest
        order by sa_ente, sa_fecha_tran, sa_comprobante, sa_asiento

     if @@rowcount = 0
     begin       
         print 'No existen registros de retencion'
	     set rowcount 0
	     return 1
     end
     set rowcount 0
end

if @i_operacion = 'I' -- Consulta certificado ICA
begin	 

    truncate table cb_tempsaldos

    if (@i_fecha_i is null) and (@i_fecha_f is null)
    begin
         print 'Falta Fecha de proceso'
         return 1
    end
    
    while (@i_fecha_i <= @i_fecha_f)
    begin
    
            insert into cob_conta..cb_tempsaldos (cliente,             cod_oficina,     nom_oficina,     
                                                  des_ica,             comprobante,     x_mil,           
                                                  fecha,               base,            valorica,        
                                                  siguiente1,          siguiente3,      siguiente4,      
                                                  bimestre,            rangobmt)   
            select
                 sa_ente,           
                 convert(varchar(5),of_oficina),
                 substring(of_nombre,1,35), 
                 convert(varchar(35),ic_descripcion),    
                 convert(varchar(12),sa_producto)+'/'+convert(varchar(12),sc_comp_definit), 
                 ic_porcentaje, 
                 sa_fecha_tran,
                 CASE 
                       WHEN sa_concepto like'%REV%' THEN round(sa_base,0) * -1 
    	   	     ELSE 
                       round(sa_base,0)
                 END,               
                 CASE 
                       WHEN sa_concepto like'%REV%' THEN round(sa_valor_ica,0) * -1 
    	   	     ELSE 
                       round(sa_valor_ica,0)
                 END,                          
                 ic_ciudad,
                 sa_comprobante,
                 sa_asiento,                             
                 convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2)),                         
                 convert(datetime,convert(char(10),dateadd(mm,-2,dateadd(mm,convert(int,ceiling(convert(float,datepart(mm,sa_fecha_tran))/2))*2,dateadd(dd,-datepart(dy,sa_fecha_tran)+1,sa_fecha_tran))),101),101)
                from cob_conta_tercero..ct_sasiento, 
                     cob_conta_tercero..ct_scomprobante,
                     cobis..cl_oficina,
                     cob_conta..cb_ica,
                     cob_conta..cb_cuenta_proceso
                where sa_fecha_tran  = @w_fecha_ini
                and   sa_mayorizado  =  'S'  
                and   sa_ente        > 0
                and   sa_empresa     = @i_empresa
                and   sa_cuenta      > '0'
                and   sa_comprobante > 0
                and   sa_producto    > 0
                and   sa_con_ica     is not NULL
                and   sa_con_ica     = ic_codigo       
                and   sc_producto    = sa_producto                
                and   sc_fecha_tran  = sa_fecha_tran
                and   sc_comprobante = sa_comprobante
                and   sc_empresa     = sa_empresa
                and   of_oficina     = sa_oficina_dest
                and   of_ciudad      = ic_ciudad       
                and   ic_empresa     = @i_empresa
                and   ic_debcred     = 'C'
                and   ic_codigo      > '0'
                and   ic_ciudad      > 0
                and   cp_empresa     = @i_empresa
                and   cp_proceso     = 6095
                and   cp_cuenta      = sa_cuenta
                order by sa_ente, of_ciudad, sa_fecha_tran, sa_comprobante, sa_asiento
    print  @i_fecha_i
    select @i_fecha_i = DATEADD(day, 1, @i_fecha_i)
    end
end

return 0

go

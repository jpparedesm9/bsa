/************************************************************************/
/*    Archivo:         banco.sp                                         */
/*    Stored procedure:     sp_banco                                    */
/*    Base de datos:      cob_cuentas                                   */
/*    Producto:         Cuentas Corrientes                              */
/*    Disenado por:          Mauricio Bayas/Sandra Ortiz                */
/*    Fecha de escritura:     09-Jun-1994                               */
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
/*    Este programa procesa las transacciones de depositos              */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA           AUTOR          RAZON                              */
/*    09/Jun/1994     J Navarrete    Emision inicial                    */
/*    15/Ago/2016     T Baidal       Migración COBIS CLOUD México       */          
/************************************************************************/
use cob_cuentas
go

if exists (select * from sysobjects where name = 'sp_banco')
        drop proc sp_banco

go
create proc sp_banco (
    @t_debug        char(1)  = 'N',
    @t_trn          int      = 18,
    @t_file         char(1)  = null,
    @i_help         char(1)  = null,
    @i_filial       tinyint,
    @i_bco          smallint = null,
    @i_tran         char(1)  = null,
    @i_modo         int      = 0,
    @i_secuencial   int      = null
)
as

declare @w_bco      smallint

/* Determinar el codigo de banco */
select @w_bco      = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'CTE'
   and pa_nemonico = 'CBCO'
if @@rowcount      = 0
begin
    exec cobis..sp_cerror
         @i_num    = 201196
    return 1
end

if @i_help = 'A'
begin
    set rowcount 20
    if @i_tran = 'O'
    begin
        if @i_modo = 0
            select   
			'5284'   = ba_banco, 
			'502128' = ba_descripcion
            from     cob_remesas..re_banco
            where    ba_filial = @i_filial
            and      ba_banco != @w_bco
            order by ba_banco
        else
        begin
            if @i_modo = 1
                select   
			   '5284'   = ba_banco,
			   '502128' = ba_descripcion
                from     cob_remesas..re_banco
                where    ba_filial = @i_filial
                and      ba_banco != @w_bco
                and      ba_banco  > @i_secuencial
                order by ba_banco
        end
    end
    else
    begin
        if @i_modo = 0
            select   
			'5284'   = ba_banco, 
			'502128' = ba_descripcion
            from     cob_remesas..re_banco
            where    ba_filial = @i_filial
            order by ba_banco
        else
        begin
            if @i_modo = 1
                select   
				'5284'   = ba_banco, 
				'502128' = ba_descripcion
                from     cob_remesas..re_banco
                where    ba_filial = @i_filial
                and      ba_banco  > @i_secuencial
                order by ba_banco
        end
    end
end
else
   if (@i_bco != @w_bco or @i_tran != 'O') and isnull(@i_bco, 0) != @w_bco
   begin
        select ba_descripcion
        from cob_remesas..re_banco
        where ba_banco = @i_bco
        if @@rowcount  = 0
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = 'sp_banco',
                @i_num      = 201091
            return 1
                
        end
   end
return 0
go

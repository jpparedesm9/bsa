/************************************************************************/
/*  Archivo:            sp_plazas_bco_rep.sp                            */
/*  Stored procedure:   sp_plazas_bco_rep                               */
/*  Base de datos:      cob_cuentas                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'COBISCorp'.                                                        */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
USE cob_cuentas
GO

/****** Object:  StoredProcedure [dbo].[sp_plazas_bco_rep]    Script Date: 07/06/2016 11:32:24 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

if exists (select 1 from sysobjects where name = 'sp_plazas_bco_rep')
   drop proc sp_plazas_bco_rep
GO

CREATE proc sp_plazas_bco_rep (
       @s_srv                varchar(16) = null,
       @t_debug              char(1) = 'N', 
       @t_file               varchar(14) = null,
       @t_from               varchar(32) = null,
       @t_trn                smallint,
       @i_operacion          char(1),
       @i_plaza              smallint = 0,
       @i_oficina       smallint = 0      
)
as

declare @w_sp_name                 varchar(64),
      @w_return               int        

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_plazas_bco_rep'

/*  Valida codigo de Transaccion  */
if @t_trn != 2564
begin
   /*  Error en codigo de transaccion  */
   exec cobis..sp_cerror
      @t_debug= @t_debug,
      @t_file= @t_file,
      @t_from= @w_sp_name,
      @i_num      = 201048
      return 201048
end


if @i_operacion = 'I'
begin
   
   if exists (select 1 from 
            cob_cuentas..cc_plazas_bco_rep
            where pb_plaza   = @i_plaza
                and pb_oficina = @i_oficina)
   begin
      /* Ya existe relacion Plaza-Oficina */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201178
      return 201178         
   end

   if exists (select 1 from 
            cob_cuentas..cc_plazas_bco_rep
            where pb_oficina = @i_oficina)
   begin
      /* Oficina ya se encuentra relacionada  */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201236
      return 201236
   end

   begin tran

   insert cob_cuentas..cc_plazas_bco_rep
   values (@i_plaza, @i_oficina)
   if @@error <> 0
   begin
      /* Error en insercion relacion Plaza-Oficina */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203006
      return 203006
   end

   commit tran

end


if @i_operacion = 'D'
begin

   if not exists (select 1 from 
                cob_cuentas..cc_plazas_bco_rep
                where pb_plaza   = @i_plaza
                    and pb_oficina = @i_oficina)
   begin
      /* No existe relacion Plaza-Oficina */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201191
      return 201191
   end

   begin tran

   delete cob_cuentas..cc_plazas_bco_rep
   where pb_plaza   = @i_plaza
     and pb_oficina = @i_oficina
   if @@error <> 0
   begin
      /* Error en eliminacion relacion Plaza-Oficina */
      exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 207020
      return 207020
   end

   commit tran
end


if @i_operacion = 'S'
begin

   set rowcount 56   
   select 'COD.'    = pb_plaza,
          'PLAZA'   = valor,
          'OF.'     = pb_oficina,
          'OFICINA' = substring(of_nombre,1,40)
   from cob_cuentas..cc_plazas_bco_rep, cobis..cl_catalogo, cobis..cl_oficina
   where (pb_plaza > @i_plaza
      or (pb_plaza = @i_plaza and pb_oficina > @i_oficina))
     and convert(char(10),pb_plaza) = codigo
     and tabla = (select codigo from cobis..cl_tabla where tabla = 'cc_plazas_bco_rep')
     and pb_oficina = of_oficina
   set rowcount 0
   
end


return 0


GO

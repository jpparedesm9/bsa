/****************************************************************************/
/*     Archivo:     qry_tranms.sp                                           */
/*     Stored procedure: sp_qry_tranms                                      */
/*     Base de datos: cob_remesas                                           */
/*     Producto: Personalizacion                                            */
/*     Disenado por:    Jorge Baque                                         */
/*     Fecha de escritura: 13/May/2016                                      */
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
/*                                                                          */
/****************************************************************************/
/*                           MODIFICACIONES                                 */
/*       FECHA          AUTOR           RAZON                               */
/*     13/May/2016     Jorge Baque     Migracion a CEN                      */
/****************************************************************************/
use cob_remesas
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_qry_tranms')
  drop proc sp_qry_tranms
go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_qry_tranms (
    @t_debug        char(1) = 'N',
    @t_file         char(1) =  null,
    @t_trn          smallint,
    @i_producto     varchar(3),
    @i_qry          char(1),
    @i_tipohis      char(1),
    @i_tipotrn      int,
    @i_ultimo       int = 0 
)
as

declare @w_sp_name varchar(30)

select @w_sp_name = 'sp_qry_tranms'
if @t_trn != 2576 and @t_trn != 499
begin
   /* Error en codigo de transaccion */
   exec cobis..sp_cerror
   @t_debug     = @t_debug,
   @t_file      = @t_file,
   @t_from      = @w_sp_name,
   @i_num       = 201002 
   return 1
end

if @i_producto = 'CTE'
begin
   if @i_tipohis = 'M'
   begin        
      if @i_qry = 'T'     /* T)odas */
      begin
         set rowcount 20
         select 'CODIGO'       = tn_trn_code,
                'DESCRIPCION'  = tn_descripcion
         from   cobis..cl_ttransaccion
         where tn_trn_code in (31,40,48,50,51,52,55,57,71,76,81,85,
                               2502,2519,2520,2542,2553,2597,2626,2627)
         and tn_trn_code > @i_ultimo  
         set rowcount 0
      end
      else
      begin
         set rowcount 20
         if @i_qry = 'I'  /* I)ndividual */
         begin
            select 'DESCRIPCION'  = tn_descripcion
            from   cobis..cl_ttransaccion
            where  tn_trn_code in (31,40,48,50,51,52,55,57,71,76,81,85,2502,2519,2520,2542,2553,2597,2626,2627)
            and    tn_trn_code = @i_tipotrn
            if @@rowcount = 0
            begin
               /* No existe tipo de transaccion */
               exec cobis..sp_cerror
               @t_debug    = @t_debug,
               @t_file = @t_file,
               @t_from = 'sp_qry_tranms',
               @i_num = 208019
             return 1
            end
         end
         set rowcount 0
      end
      return 0
   end
   
   if @i_tipohis = 'S'
   begin        
      if @i_qry = 'T'    /* T)odas */
      begin
         set rowcount 20
         select 'CODIGO'       = tn_trn_code,
                'DESCRIPCION'  = tn_descripcion
         from   cobis..cl_ttransaccion
         where  tn_trn_code in (1,2,3,4,5,6,9,10,11,12,13,15,20,21,22,23,24,25,
                                26,27,28,29,32,36,37,42,45,53,60,61,62,63,64,65,66,
                                67,68,69,70,75,77,79,86,91,401,402,403,404,406,416,
                                421,422,2501,2504,2505,2506,2507,2510,2511,15151,
                                15150,15155,15156,2518,2530,2531,2532,2534,2535,
                                2536,2538,2539,2541,2547,2548,2549,2556,2557,2558,
                                2559,2560,2563,2569,2570,2572,2619,2760,2761, 
                                2773,2774,2775,2781,2782,2783,2784,2785,2786,2787,2789,
                                2790,2791,2797,2798,2799,2800,2819,2820,
                                2781,2782,2783,2784,2785,2786,2787,2788,2789,2790,2791,2928)
         and tn_trn_code > @i_ultimo  
         set rowcount 0
      end
      else
      begin
         set rowcount 20
         if @i_qry = 'I'    /* I)ndividual */
         begin
            select 'DESCRIPCION'  = tn_descripcion
            from   cobis..cl_ttransaccion
            where tn_trn_code in (1,2,3,4,5,6,9,10,11,12,13,15,20,21,22,
                                  23,24,25,26,27,28,29,32,36,37,42,45,53,60,
                                  61,62,63,64,65,66,67,68,69,70,75,77,79,86,
                                  91,401,402,403,404,406,416,421,422,2501,
                                  2504,2505,2506,2507,2510,2511,
                                  15151,15150,15155,15156,2518,2530,2531,
                                  2532,2534,2535,
                                  2536,2538,2539,2541,2547,2548,2549,2556,2557,2558,
                                  2559,2560,2563,2569,2570,2572,2619,
                                  2760,2761,2773,2774,2775,
                                  2781,2782,2783,2784,2785,2786,2787,2789,
                                  2790,2791,2797,2798,2799,2800,2819,2820,
                                  2781,2782,2783,2784,2785,2786,2787,2788,2789,2790,2791,
                                  2928) 
            and tn_trn_code = @i_tipotrn
            if @@rowcount = 0
            begin
              /* No existe tipo de transaccion */
                exec cobis..sp_cerror
                @t_debug   = @t_debug,
                @t_file    = @t_file,
                @t_from    = 'sp_qry_tranms',
                @i_num = 208020
             return 1
            end
         end
         set rowcount 0
      end
      return 0
   end
end 

if @i_producto = 'AHO'
begin
   /* Historico de Consultas Monetarias*/
   if @i_tipohis = 'M'
   begin        
      if @i_qry = 'T'     /* T)odas */
      begin
         set rowcount 20
         select 'CODIGO'       = tn_trn_code,
                'DESCRIPCION'  = tn_descripcion
         from   cobis..cl_ttransaccion
         where tn_trn_code in (select ah_transaccion_m from cob_ahorros..cp_campoah_monetario)
         and   tn_trn_code > @i_ultimo  
         order by tn_trn_code
         set rowcount 0
      end
      else
      begin
         set rowcount 20
         if @i_qry = 'I'  /* I)ndividual */
         begin
            select 'DESCRIPCION'  = tn_descripcion
            from   cobis..cl_ttransaccion
            where tn_trn_code in (select ah_transaccion_m from cob_ahorros..cp_campoah_monetario)
            and tn_trn_code = @i_tipotrn
            if @@rowcount = 0
            begin
              /* No existe tipo de transaccion */
                 exec cobis..sp_cerror
                 @t_debug   = @t_debug,
                 @t_file    = @t_file,
                 @t_from    = 'sp_qry_tranms',
                 @i_num = 208019
              return 1
            end
         end
         set rowcount 0
      end
      return 0
   end

   /*Historico de Consultas de Servicios*/
   if @i_tipohis = 'S'
   begin        
      if @i_qry = 'T'     /* T)odas */
      begin
         set rowcount 20
         select 'CODIGO'       = tn_trn_code,
                'DESCRIPCION'  = tn_descripcion
         from   cobis..cl_ttransaccion
         where  tn_trn_code in (select cc_transaccion from cob_ahorros..cp_campoah)
         and    tn_trn_code > @i_ultimo  
         order by tn_trn_code
         set rowcount 0
      end
      else
      begin
         set rowcount 20
         if @i_qry = 'I'  /* I)ndividual */
         begin
            select 'DESCRIPCION'  = tn_descripcion
            from   cobis..cl_ttransaccion
            where tn_trn_code in (select cc_transaccion from cob_ahorros..cp_campoah)
            and tn_trn_code = @i_tipotrn
            if @@rowcount = 0
            begin
              /* No existe tipo de transaccion */
                 exec cobis..sp_cerror
                 @t_debug  = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = 'sp_qry_tranms',
                 @i_num    = 208020
              return 1
            end
         end
         set rowcount 0
      end
      return 0
   end
end
return 0


GO



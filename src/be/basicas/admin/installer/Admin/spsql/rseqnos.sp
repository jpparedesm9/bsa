/***********************************************************************/

/* rseqnos: Numeros secuenciales para reentry                          */

/* pml: 93/06/08: Tomado de sp_cseqnos                                 */

/* PROCEDURE: sp_rseqnos                                               */

/***********************************************************************/

use cobis
go



if exists (select * from sysobjects where name = 'sp_rseqnos')

    drop proc sp_rseqnos

go



create proc sp_rseqnos 

(

    @t_debug            char(1) = 'N',

    @t_file             varchar(14) = null,

    @t_from             varchar(32) = null,

    @i_tabla            varchar(30), 

    @o_siguiente        int = null     out

)

as

declare @w_return    int,

        @w_sp_name    varchar(30)



/*  Captura nombre de Stored Procedure  */

select  @w_sp_name = 'sp_rseqnos'



/*  Modo de debug  */

if @t_debug = 'S'

begin

        exec cobis..sp_begin_debug @t_file = @t_file

        select '/**  Stored Procedure  **/ ' = @w_sp_name,

               t_from  = @w_sp_name,

               i_tabla    = @i_tabla

        exec cobis..sp_end_debug

end



begin tran

if not exists

    (select siguiente

     from cobis..re_seqnos

     where tabla = @i_tabla )

begin

             



exec cobis..sp_cerror

    @t_debug  = @t_debug,

    @t_file   = @t_file,

    @t_from   = @w_sp_name,

    @i_num    = 151028

    return 1

end

update re_seqnos

    set siguiente = siguiente + 1

    where tabla = @i_tabla

if @@error != 0

begin

    exec cobis..sp_cerror

        @t_debug = @t_debug,

        @t_file  = @t_file,

        @t_from  = @w_sp_name,

        @i_num   = 105001

    return 1

end

select @o_siguiente = siguiente

from cobis..re_seqnos

where tabla = @i_tabla

if @t_debug = 'S'

begin

    exec cobis..sp_begin_debug @t_file = @t_file

    select o_siguiente = @o_siguiente

    exec cobis..sp_end_debug

end

commit tran

go


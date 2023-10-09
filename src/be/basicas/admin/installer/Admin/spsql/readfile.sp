use cobis
go



if exists (select * from sysobjects where name = 'sp_readfile')

    drop proc sp_readfile

go



create proc sp_readfile (

    @i_fileName    varchar(64),

    @i_offset      int,

    @i_numlines    smallint,

    @i_dir         char(1),

    @o_numlines    int = NULL output,

    @o_more        tinyint = NULL output,

    @o_of_ini      int = NULL output,

    @o_of_fin      int = NULL output

)

as

exec ADMIN...rp_readfile

     @i_fileName    = @i_fileName,

     @i_offset      = @i_offset,

     @i_numlines    = @i_numlines,

     @i_dir         = @i_dir,

     @o_numlines    = @o_numlines out,

     @o_more        = @o_more out,

     @o_of_ini      = @o_of_ini out,

     @o_of_fin      = @o_of_fin out

return 0

go


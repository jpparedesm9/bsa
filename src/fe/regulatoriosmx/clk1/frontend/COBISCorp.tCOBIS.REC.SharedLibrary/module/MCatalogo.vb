Public Class Catalogo
    Private mCodigo As String
    Private mDescripcion As String
    Public Sub New(ByVal parCodigo As String, ByVal parDescripcion As String)
        mCodigo = parCodigo
        mDescripcion = parDescripcion
    End Sub
    Public ReadOnly Property Codigo() As String
        Get
            Return mCodigo
        End Get
    End Property
    Public ReadOnly Property Descripcion() As String
        Get
            Return mDescripcion
        End Get
    End Property
End Class

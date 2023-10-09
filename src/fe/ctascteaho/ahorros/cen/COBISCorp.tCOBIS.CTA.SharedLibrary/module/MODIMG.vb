Option Strict Off
Option Explicit On
Public Module MODIMG
    Public VGBitmap32 As COBISCorp.Framework.UI.Components.COBISBitmapObject
    Public VGGrafo As Object 'JSA 
    Public Sub BitMap(ByRef Picture As COBISCorp.Framework.UI.Components.COBISGrid, ByVal lpBits As String, ByVal Col As Integer, ByVal Row As Integer)
        VGBitmap32.BitmapNet(Picture, lpBits, CShort(Col), CShort(Row))
    End Sub
End Module



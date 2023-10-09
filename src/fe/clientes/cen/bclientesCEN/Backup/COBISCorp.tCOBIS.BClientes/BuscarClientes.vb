Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
<System.Runtime.InteropServices.ProgId("BuscarClientes_NET.BuscarClientes")> _
public Class BuscarClientes
	Private VLFBuscarC As New FBuscarClienteClass
	Private VLDatosCliente() As String
	Private VLCodigoCliente As String = ""
	Private VLNombreCliente As String = ""
	Private VLOrigenCliente As String = ""
	Private VLDireccionesCliente( ,  ) As String
	Private VLTelefonosCliente( ,  ) As String
	Private VLOtrosDatosCliente( ,  ) As String

	Public Sub New()
		MyBase.New()
		ReDim VLDatosCliente(1)
		ReDim VLDireccionesCliente(1, 0)
		ReDim VLTelefonosCliente(1, 0)
		ReDim VLOtrosDatosCliente(0, 1)
	End Sub

	Protected Overrides Sub Finalize()
		VLFBuscarC.Close()
		VLFBuscarC = Nothing
	End Sub

	Private Shared _DefaultInstance As BuscarClientes = Nothing

	Public Shared ReadOnly Property DefaultInstance() As BuscarClientes
		Get
			If _DefaultInstance Is Nothing Then
				_DefaultInstance = New BuscarClientes
			End If
			Return _DefaultInstance
		End Get
	End Property
End Class


Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
<System.Runtime.InteropServices.ProgId("BuscarClientes_NET.BuscarClientes")> _
public Class BuscarClientes
	Private VLFBuscarC As New FBuscarClienteClass
    Public VLDatosCliente() As String
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


    Public Function PMRetornaCliente() As String()
        Return VGDatosCliente
    End Function

    Public Sub FMObtenerProducto(ByRef producto As String, ByRef tipocliente As String)
        VGProducto = producto
        VGTipoCli = tipocliente
    End Sub

    Public Function FMBuscarCliente(ByRef parFMain As Object, ByRef parMapeador As Object, ByVal parConexion As Integer, ByVal parServidor As String, ByVal parServLocal As String, ByRef parFormato As String, ByRef parol As String) As Boolean
        Dim result As Boolean = False
        Dim VGrol As String = String.Empty
        Dim ServerNameLocal As String = String.Empty
        Dim ServerName As String = String.Empty
        Dim SqlConn As Integer = 0
        '**********************************************************************
        'PROPOSITO:   Llama a la forma de Busqueda de Clientes
        '**********************************************************************
        'INPUT:   parFMain      Apuntador a la Forma principal del módulo cliente
        '         parMapeador   Apuntador al Mapeador del módulo cliente
        '         parConexion   Número de Conexión del módulo cliente
        '         parServidor   Nombre del Servidor del módulo cliente
        '         parServLocal   Nombre del Servidor Local del módulo cliente
        '         parFormato    Formato de Fecha del módulo cliente
        'OUTPUT:  FMBuscarCliente True - Si se escogio algun cliente
        '                         False - Si no se escogieron clientes
        '**********************************************************************
        '                    MODIFICACIONES
        ' FECHA         AUTOR           RAZON
        ' 02/Oct/98     Myriam Dávila   Emision Inicial
        ' 25/Feb/03     Sandro Soto     No procesar funcion de seguridad para
        '                               encontrar las transacciones autorizadas
        '**********************************************************************

        Dim VTNumDireccionesCliente As Integer = 0
        Dim VTNumTelefonosCliente As String = ""

        'Inicializar Variables Globales
        Dim VGDatosCliente(1) As String
        Dim VGDireccionesCliente(1, 0) As String
        Dim VGTelefonosCliente(1, 0) As String
        Dim VGOtrosDatosCliente(0, 1) As String
        Dim VGCodigoCliente As String = ""
        Dim VGNombreCliente As String = ""
        Dim VGOrigenCliente As String = ""
        Dim VGFormato As String = ""

        'Liberar Variables Globales de conexión
        'Set VGrol = Nothing
        SqlConn = 0
        ServerName = ""
        ServerNameLocal = ""
        VGrol = ""

        'Inicializar Variables Globales de conexión
        Dim VGMap As Object = parMapeador
        Dim fMain As Object = parFMain
        SqlConn = parConexion
        ServerName = parServidor
        ServerNameLocal = parServLocal
        VGFormato = parFormato
        VGrol = parol
        'Llamar a la Forma
        'UPGRADE_TODO: (1067) Member Show is not defined in type FBuscarCliente. More Information: http://www.vbtonet.com/ewis/ewi1067.aspx
        '  VLFBuscarC.Show(FormShowConstants.Modal)

        If VGDatosCliente(1) <> "" Then
            'inicializar variables privadas de la clase
            VLCodigoCliente = VGDatosCliente(1)
            If VGDatosCliente(0) = "P" Then
                VLNombreCliente = VGDatosCliente(2) & Strings.ChrW(32).ToString() & VGDatosCliente(3) & Strings.ChrW(32).ToString() & VGDatosCliente(4)
            Else
                VLNombreCliente = VGDatosCliente(2)
            End If
            VLOrigenCliente = VGOrigenCliente
            ReDim VLDatosCliente(VGDatosCliente.GetUpperBound(0))
            For VTi As Integer = 0 To VGDatosCliente.GetUpperBound(0)
                VLDatosCliente(VTi) = VGDatosCliente(VTi)
                Debug.WriteLine(CStr(VTi) & " = " & VLDatosCliente(VTi))
            Next VTi

            VTNumDireccionesCliente = VGDireccionesCliente.GetUpperBound(1)
            VTNumTelefonosCliente = CStr(VGTelefonosCliente.GetUpperBound(1))
            ReDim VLDireccionesCliente(1, VTNumDireccionesCliente)
            ReDim VLTelefonosCliente(1, CInt(VTNumTelefonosCliente))
            For VTi As Integer = 1 To VTNumDireccionesCliente
                VLDireccionesCliente(0, VTi) = VGDireccionesCliente(0, VTi)
                VLDireccionesCliente(1, VTi) = VGDireccionesCliente(1, VTi)
            Next VTi
            For VTi As Integer = 1 To CInt(VTNumTelefonosCliente)
                VLTelefonosCliente(0, VTi) = VGTelefonosCliente(0, VTi)
                VLTelefonosCliente(1, VTi) = VGTelefonosCliente(1, VTi)
            Next VTi

            ReDim VLOtrosDatosCliente(VGOtrosDatosCliente.GetUpperBound(0), 1)
            For VTi As Integer = 0 To VGOtrosDatosCliente.GetUpperBound(0)
                VLOtrosDatosCliente(VTi, 1) = VGOtrosDatosCliente(VTi, 1)
            Next VTi
            'poner el valor de retorno en el método
            result = True
        Else
            'inicializar variables privadas de la clase
            VLCodigoCliente = ""
            VLNombreCliente = ""
            VLOrigenCliente = ""
            ReDim VLDatosCliente(1)
            ReDim VLDireccionesCliente(1, 0)
            ReDim VLTelefonosCliente(1, 0)
            ReDim VLOtrosDatosCliente(0, 1)
            'poner el valor de retorno en el método
            result = False
        End If
        Return result
    End Function


    Public ReadOnly Property DatosCliente(ByVal parIndice As Integer) As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al contenido
            '             del arreglo de Datos VGDatosCliente
            '*******************************************************
            'INPUT:       parIndice   Elemento del Arreglo que deseo
            '                         obtener su valor
            'OUTPUT:      DatosCliente  Contenido del indice del
            '                         Arreglo.
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLDatosCliente(parIndice)
        End Get
    End Property

    Public ReadOnly Property OtrosDatosCliente(ByVal parIndice As Integer) As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al contenido
            '             del arreglo de Datos VGDatosCliente
            '*******************************************************
            'INPUT:       parIndice   Elemento del Arreglo que deseo
            '                         obtener su valor
            'OUTPUT:      DatosCliente  Contenido del indice del
            '                         Arreglo.
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLOtrosDatosCliente(parIndice, 1)
        End Get
    End Property


    Public ReadOnly Property CodigoCliente() As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al código
            '             del cliente escogido
            '*******************************************************
            'INPUT:       Indice
            'OUTPUT:      CodigoCliente  Código del Cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLCodigoCliente
        End Get
    End Property


    Public ReadOnly Property NombreCliente() As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al código
            '             del cliente escogido
            '*******************************************************
            'INPUT:       Indice
            'OUTPUT:      CodigoCliente  Código del Cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLNombreCliente
        End Get
    End Property


    Public ReadOnly Property NumeroDatosCliente() As Integer
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al número de
            '             Datos en la propiedad DatosCliente
            '*******************************************************
            'INPUT:       Indice
            'OUTPUT:      CodigoCliente  Código del Cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLDatosCliente.GetUpperBound(0)
        End Get
    End Property

    Public ReadOnly Property NumeroOtrosDatosCliente() As Integer
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al número de
            '             Datos en la propiedad DatosCliente
            '*******************************************************
            'INPUT:       Indice
            'OUTPUT:      CodigoCliente  Código del Cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLOtrosDatosCliente.GetUpperBound(0)
        End Get
    End Property

    Public ReadOnly Property OrigenCliente() As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al origen
            '             del cliente en la propiedad DatosCliente
            '*******************************************************
            'INPUT:
            'OUTPUT:      OrigenCliente   Origen del cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '29/Feb/00     B.Borja         Emision Inicial
            '*******************************************************
            Return VLOrigenCliente
        End Get
    End Property

    Public ReadOnly Property DireccionesCliente(ByVal parIndice1 As Integer, ByVal parIndice2 As Integer) As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al número de
            '             Datos en la propiedad DatosCliente
            '*******************************************************
            'OUTPUT:      NumDireccionesCliente  Numero de
            '             direcciones del cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA          AUTOR           RAZON
            '28/03/2001     V.Torres    Emision Inicial
            '*******************************************************
            Return VLDireccionesCliente(parIndice1, parIndice2)
        End Get
    End Property

    Public ReadOnly Property TelefonosCliente(ByVal parIndice1 As Integer, ByVal parIndice2 As Integer) As String
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al número de
            '             Datos en la propiedad DatosCliente
            '*******************************************************
            'OUTPUT:      NumDireccionesCliente  Numero de
            '             Telefonos del cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA          AUTOR           RAZON
            '28/03/2001     V.Torres    Emision Inicial
            '*******************************************************
            Return VLTelefonosCliente(parIndice1, parIndice2)
        End Get
    End Property

    Public ReadOnly Property NumDireccionesCliente() As Integer
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al número de
            '             Datos en la propiedad DatosCliente
            '*******************************************************
            'INPUT:       Indice
            'OUTPUT:      CodigoCliente  Código del Cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLDireccionesCliente.GetUpperBound(1)
        End Get
    End Property


    Public ReadOnly Property NumTelefonosCliente() As Integer
        Get
            '*******************************************************
            'PROPOSITO:   Esta propiedad permite acceder al número de
            '             Datos en la propiedad DatosCliente
            '*******************************************************
            'INPUT:       Indice
            'OUTPUT:      CodigoCliente  Código del Cliente
            '*******************************************************
            '                    MODIFICACIONES
            'FECHA         AUTOR           RAZON
            '05/Oct/98     M.Davila        Emision Inicial
            '*******************************************************
            Return VLTelefonosCliente.GetUpperBound(1)
        End Get
    End Property


    Public Sub Cabecera_Busqueda(ByRef valore As Boolean, ByRef valor0 As Boolean, ByRef valor1 As Boolean, ByRef valor2 As Boolean, ByRef valor As Integer)
        '**************************************************************
        'PROPOSITO:   Esta funcion permite establecer de que tipo
        '             de cliente es la busqueda
        '**************************************************************
        'INPUT:       valore    Define si es visible o no el boton
        '                       escoger
        '             valor0    Define si la busqueda es de C.Juridicos
        '             valor1    Define si la busqueda es de C.Naturales
        '             valor2    Define si la busqueda es de C.Cifrados
        '             valor     1 Permite que las opciones de busqueda
        '                       (C. Juridicos, C. Naturales, C. Cifrados)
        '                       se habiliten o no de acuerdo a los valores
        '                       establecidos
        ' La variable VGValor2 permite establecer si la busqueda de C.
        ' Cifrados es visible o no en la pantalla de busqueda.
        '**************************************************************

        VLFBuscarC.cmdEscoger.Visible = valore
        Dim VGvalor2 As Boolean = valor2
        If valor = 1 Then
            VLFBuscarC.optCliente(1).Enabled = valor1
            VLFBuscarC.optCliente(0).Enabled = valor0
            VLFBuscarC.optCliente(2).Enabled = valor2
        End If

        VLFBuscarC.optCliente(1).Checked = valor1
        VLFBuscarC.optCliente(0).Checked = valor0
        VLFBuscarC.optCliente(2).Checked = valor2

    End Sub

End Class


Imports COBISCorp.tCOBIS.TADMIN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FHistoricoASClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializetxtCampo()
		InitializemskValor()
		InitializelblEtiqueta()
		InitializelblDescripcion()
		Initializeil_mascara()
		InitializecmdBoton()
		'This form is an MDI child.
		'This code simulates the Compatibility.VB6 
		' functionality of automatically
		' loading and showing an MDI
		' child's parent.
		'The MDI form in the Compatibility.VB6 project had its
		'AutoShowChildren property set to True
		'To simulate the Compatibility.VB6 behavior, we need to
		'automatically Show the form whenever it
		'is loaded.  If you do not want this behavior
		'then delete the following line of code
		'UPGRADE_TODO: (2018) Remove the next line of code to stop form from automatically showing. More Information: http://www.vbtonet.com/ewis/ewi2018.aspx
	End Sub
    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub
    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
     Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Public WithEvents mskFecha As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _txtCampo_1 As System.Windows.Forms.TextBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Public WithEvents mskfechahasta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_0 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _mskValor_1 As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_7 As System.Windows.Forms.Button
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISSpread
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_2 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_7 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_8 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_5 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_4 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_1 As System.Windows.Forms.Label
    Private WithEvents _il_mascara_0 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Public Line1(1) As System.Windows.Forms.Label
    Public cmdBoton(7) As System.Windows.Forms.Button
    Public il_mascara(9) As System.Windows.Forms.Label
    Public lblDescripcion(4) As System.Windows.Forms.Label
    Public lblEtiqueta(1) As System.Windows.Forms.Label
    Public mskValor(1) As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public txtCampo(5) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
     Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FHistoricoASClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me.mskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._txtCampo_1 = New System.Windows.Forms.TextBox()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me.mskfechahasta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_0 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._mskValor_1 = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_7 = New System.Windows.Forms.Button()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdRegistros_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._il_mascara_2 = New System.Windows.Forms.Label()
        Me._il_mascara_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._il_mascara_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._il_mascara_7 = New System.Windows.Forms.Label()
        Me._il_mascara_8 = New System.Windows.Forms.Label()
        Me._il_mascara_5 = New System.Windows.Forms.Label()
        Me._il_mascara_4 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._il_mascara_1 = New System.Windows.Forms.Label()
        Me._il_mascara_0 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GBRegistros = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBImprimir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.TSBExcel = New System.Windows.Forms.ToolStripButton()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdRegistros_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GBRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GBRegistros.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.ContainerForm = Me
        Me.COBISViewResizer.EnabledResize = True
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Location = New System.Drawing.Point(134, 56)
        Me._txtCampo_0.MaxLength = 4
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(46, 20)
        Me._txtCampo_0.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Location = New System.Drawing.Point(134, 79)
        Me._txtCampo_2.MaxLength = 4
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(46, 20)
        Me._txtCampo_2.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.Color.Silver
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Enabled = False
        Me._txtCampo_4.Location = New System.Drawing.Point(132, 356)
        Me._txtCampo_4.MaxLength = 0
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.ReadOnly = True
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(118, 20)
        Me._txtCampo_4.TabIndex = 27
        Me._txtCampo_4.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._txtCampo_4.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.Color.Silver
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Enabled = False
        Me._txtCampo_5.Location = New System.Drawing.Point(440, 356)
        Me._txtCampo_5.MaxLength = 0
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.ReadOnly = True
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(118, 20)
        Me._txtCampo_5.TabIndex = 26
        Me._txtCampo_5.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me._txtCampo_5.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Location = New System.Drawing.Point(134, 125)
        Me._txtCampo_3.MaxLength = 2
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(46, 20)
        Me._txtCampo_3.TabIndex = 7
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(134, 148)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(107, 20)
        Me.mskCuenta.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        '_cmdBoton_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_1, False)
        Me._cmdBoton_1.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_1, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_1, True)
        Me._cmdBoton_1.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_1, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_1, Nothing)
        Me._cmdBoton_1.Enabled = False
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Location = New System.Drawing.Point(-561, 51)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 10
        Me._cmdBoton_1.TabStop = False
        Me._cmdBoton_1.Text = "*Si&guiente"
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        'mskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFecha, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFecha, "Default")
        Me.mskFecha.DateType = COBISCorp.Framework.UI.Components.ENUM_DATE.dd_mm_yyyy
        Me.mskFecha.Length = CType(64, Short)
        Me.mskFecha.Location = New System.Drawing.Point(134, 33)
        Me.mskFecha.Mask = "##/##/####"
        Me.mskFecha.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFecha.MaxReal = 3.402823E+38!
        Me.mskFecha.MinReal = -3.402823E+38!
        Me.mskFecha.Name = "mskFecha"
        Me.mskFecha.Size = New System.Drawing.Size(89, 20)
        Me.mskFecha.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFecha, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me._txtCampo_1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_1.Location = New System.Drawing.Point(134, 9)
        Me._txtCampo_1.MaxLength = 4
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_1.Size = New System.Drawing.Size(46, 20)
        Me._txtCampo_1.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_cmdBoton_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_0, False)
        Me._cmdBoton_0.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_0, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_0, True)
        Me._cmdBoton_0.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_0, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_0, Nothing)
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Location = New System.Drawing.Point(-620, 53)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 9
        Me._cmdBoton_0.TabStop = False
        Me._cmdBoton_0.Text = "*&Transmitir"
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
        '
        '_cmdBoton_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(-561, 254)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 12
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Limpiar"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(-561, 305)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 13
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Salir"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        'mskfechahasta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskfechahasta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskfechahasta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskfechahasta, "Default")
        Me.mskfechahasta.DateType = COBISCorp.Framework.UI.Components.ENUM_DATE.dd_mm_yyyy
        Me.mskfechahasta.Length = CType(64, Short)
        Me.mskfechahasta.Location = New System.Drawing.Point(412, 33)
        Me.mskfechahasta.Mask = "##/##/####"
        Me.mskfechahasta.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskfechahasta.MaxReal = 3.402823E+38!
        Me.mskfechahasta.MinReal = -3.402823E+38!
        Me.mskfechahasta.Name = "mskfechahasta"
        Me.mskfechahasta.Size = New System.Drawing.Size(89, 20)
        Me.mskfechahasta.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskfechahasta, "")
        '
        '_mskValor_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_0, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_0, "Default")
        Me._mskValor_0.Length = CType(64, Short)
        Me._mskValor_0.Location = New System.Drawing.Point(134, 102)
        Me._mskValor_0.MaxReal = 3.402823E+38!
        Me._mskValor_0.MinReal = -3.402823E+38!
        Me._mskValor_0.Name = "_mskValor_0"
        Me._mskValor_0.Size = New System.Drawing.Size(118, 20)
        Me._mskValor_0.TabIndex = 5
        Me._mskValor_0.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_0, "")
        '
        '_mskValor_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._mskValor_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._mskValor_1, False)
        Me.COBISStyleProvider.SetControlStyle(Me._mskValor_1, "Default")
        Me._mskValor_1.Length = CType(64, Short)
        Me._mskValor_1.Location = New System.Drawing.Point(412, 102)
        Me._mskValor_1.MaxReal = 3.402823E+38!
        Me._mskValor_1.MinReal = -3.402823E+38!
        Me._mskValor_1.Name = "_mskValor_1"
        Me._mskValor_1.Size = New System.Drawing.Size(118, 20)
        Me._mskValor_1.TabIndex = 6
        Me._mskValor_1.Text = "#,##0.00"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._mskValor_1, "")
        '
        '_cmdBoton_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.Enabled = False
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(-561, 204)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 11
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Imprimir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'grdRegistros
        '
        Me.grdRegistros.AccessibleDescription = ""
        Me.grdRegistros.AutoClipboard = False
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdRegistros.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grdRegistros.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!)
        Me.grdRegistros.Location = New System.Drawing.Point(3, 16)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.RetainSelBlock = False
        Me.grdRegistros.RetainSelectionBlock = False
        Me.grdRegistros.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdRegistros_Sheet1})
        Me.grdRegistros.Size = New System.Drawing.Size(565, 164)
        Me.grdRegistros.StartingColNumber = 1
        Me.grdRegistros.StartingRowNumber = 1
        Me.grdRegistros.TabIndex = 10
        Me.grdRegistros.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeVGABase
        Me.grdRegistros.VisibleCols = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        'grdRegistros_Sheet1
        '
        Me.grdRegistros_Sheet1.Reset()
        Me.grdRegistros_Sheet1.SheetName = "Sheet1"
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(182, 56)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(398, 20)
        Me._lblDescripcion_0.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_il_mascara_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_2, False)
        Me._il_mascara_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_2, "Default")
        Me._il_mascara_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_2.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._il_mascara_2, "500703")
        Me._il_mascara_2.Location = New System.Drawing.Point(10, 56)
        Me._il_mascara_2.Name = "_il_mascara_2"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_2, "500703")
        Me._il_mascara_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_2.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_2.TabIndex = 32
        Me._il_mascara_2.Text = "*Oficina desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_2, "")
        '
        '_il_mascara_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_6, False)
        Me._il_mascara_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_6, "Default")
        Me._il_mascara_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_6.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_6.Location = New System.Drawing.Point(10, 79)
        Me._il_mascara_6.Name = "_il_mascara_6"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_6, "500699")
        Me._il_mascara_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_6.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_6.TabIndex = 31
        Me._il_mascara_6.Text = "*Oficina hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_6, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(182, 79)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(398, 20)
        Me._lblDescripcion_3.TabIndex = 30
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(390, 356)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(45, 20)
        Me._lblEtiqueta_0.TabIndex = 29
        Me._lblEtiqueta_0.Text = "*Total:"
        Me._lblEtiqueta_0.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(16, 356)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(123, 20)
        Me._lblEtiqueta_1.TabIndex = 28
        Me._lblEtiqueta_1.Text = "*Total de Registros:"
        Me._lblEtiqueta_1.Visible = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_il_mascara_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_9, False)
        Me._il_mascara_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_9, "Default")
        Me._il_mascara_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_9.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_9.Location = New System.Drawing.Point(10, 125)
        Me._il_mascara_9.Name = "_il_mascara_9"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_9, "5176")
        Me._il_mascara_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_9.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_9.TabIndex = 25
        Me._il_mascara_9.Text = "*Producto Bancario:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_9, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(182, 125)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(398, 20)
        Me._lblDescripcion_4.TabIndex = 24
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
        '
        '_il_mascara_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_7, False)
        Me._il_mascara_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_7, "Default")
        Me._il_mascara_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_7.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_7.Location = New System.Drawing.Point(10, 102)
        Me._il_mascara_7.Name = "_il_mascara_7"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_7, "500698")
        Me._il_mascara_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_7.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_7.TabIndex = 23
        Me._il_mascara_7.Text = "*Monto desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_7, "")
        '
        '_il_mascara_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_8, False)
        Me._il_mascara_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_8, "Default")
        Me._il_mascara_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_8.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_8.Location = New System.Drawing.Point(318, 102)
        Me._il_mascara_8.Name = "_il_mascara_8"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_8, "500697")
        Me._il_mascara_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_8.Size = New System.Drawing.Size(88, 20)
        Me._il_mascara_8.TabIndex = 22
        Me._il_mascara_8.Text = "*Monto Hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_8, "")
        '
        '_il_mascara_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_5, False)
        Me._il_mascara_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_5, "Default")
        Me._il_mascara_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_5.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_5.Location = New System.Drawing.Point(318, 33)
        Me._il_mascara_5.Name = "_il_mascara_5"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_5, "5173")
        Me._il_mascara_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_5.Size = New System.Drawing.Size(88, 20)
        Me._il_mascara_5.TabIndex = 21
        Me._il_mascara_5.Text = "*Fecha hasta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_5, "")
        '
        '_il_mascara_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_4, False)
        Me._il_mascara_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_4, "Default")
        Me._il_mascara_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_4.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_4.Location = New System.Drawing.Point(10, 148)
        Me._il_mascara_4.Name = "_il_mascara_4"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_4, "2400")
        Me._il_mascara_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_4.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_4.TabIndex = 20
        Me._il_mascara_4.Text = "*No. de Cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_4, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(244, 148)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(337, 20)
        Me._lblDescripcion_2.TabIndex = 19
        Me._lblDescripcion_2.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_il_mascara_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_1, False)
        Me._il_mascara_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_1, "Default")
        Me._il_mascara_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_1.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_1.Location = New System.Drawing.Point(10, 33)
        Me._il_mascara_1.Name = "_il_mascara_1"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_1, "5172")
        Me._il_mascara_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_1.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_1.TabIndex = 16
        Me._il_mascara_1.Text = "*Fecha desde:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_1, "")
        '
        '_il_mascara_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._il_mascara_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._il_mascara_0, False)
        Me._il_mascara_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._il_mascara_0, "Default")
        Me._il_mascara_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._il_mascara_0.ForeColor = System.Drawing.Color.Navy
        Me._il_mascara_0.Location = New System.Drawing.Point(10, 9)
        Me._il_mascara_0.Name = "_il_mascara_0"
        Me.COBISResourceProvider.SetResourceID(Me._il_mascara_0, "500689")
        Me._il_mascara_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._il_mascara_0.Size = New System.Drawing.Size(121, 20)
        Me._il_mascara_0.TabIndex = 17
        Me._il_mascara_0.Text = "*Tipo Transacción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._il_mascara_0, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(182, 9)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(398, 20)
        Me._lblDescripcion_1.TabIndex = 15
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me._txtCampo_5)
        Me.PFormas.Controls.Add(Me._txtCampo_4)
        Me.PFormas.Controls.Add(Me.GBRegistros)
        Me.PFormas.Controls.Add(Me._txtCampo_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._txtCampo_2)
        Me.PFormas.Controls.Add(Me._il_mascara_0)
        Me.PFormas.Controls.Add(Me._il_mascara_1)
        Me.PFormas.Controls.Add(Me._txtCampo_3)
        Me.PFormas.Controls.Add(Me._lblDescripcion_2)
        Me.PFormas.Controls.Add(Me.mskCuenta)
        Me.PFormas.Controls.Add(Me._il_mascara_4)
        Me.PFormas.Controls.Add(Me._il_mascara_5)
        Me.PFormas.Controls.Add(Me.mskFecha)
        Me.PFormas.Controls.Add(Me._il_mascara_8)
        Me.PFormas.Controls.Add(Me._txtCampo_1)
        Me.PFormas.Controls.Add(Me._il_mascara_7)
        Me.PFormas.Controls.Add(Me._lblDescripcion_4)
        Me.PFormas.Controls.Add(Me._il_mascara_9)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_1)
        Me.PFormas.Controls.Add(Me.mskfechahasta)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._mskValor_0)
        Me.PFormas.Controls.Add(Me._lblDescripcion_3)
        Me.PFormas.Controls.Add(Me._mskValor_1)
        Me.PFormas.Controls.Add(Me._il_mascara_6)
        Me.PFormas.Controls.Add(Me._il_mascara_2)
        Me.PFormas.Controls.Add(Me._lblDescripcion_0)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(591, 384)
        Me.PFormas.TabIndex = 34
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GBRegistros
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GBRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.GBRegistros, False)
        Me.GBRegistros.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GBRegistros.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GBRegistros, "Default")
        Me.GBRegistros.ForeColor = System.Drawing.Color.Navy
        Me.GBRegistros.Location = New System.Drawing.Point(14, 171)
        Me.GBRegistros.Name = "GBRegistros"
        Me.COBISResourceProvider.SetResourceID(Me.GBRegistros, "500688")
        Me.GBRegistros.Size = New System.Drawing.Size(571, 183)
        Me.GBRegistros.TabIndex = 9
        Me.GBRegistros.Text = "*Transacciones Realizadas"
        Me.GBRegistros.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GBRegistros, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBSiguiente, Me.TSBImprimir, Me.TSBExcel, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(611, 25)
        Me.TSBotones.TabIndex = 35
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(80, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Black
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2020")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "2306")
        Me.TSBSiguiente.Size = New System.Drawing.Size(77, 22)
        Me.TSBSiguiente.Text = "*Si&guiente"
        '
        'TSBImprimir
        '
        Me.TSBImprimir.ForeColor = System.Drawing.Color.Black
        Me.TSBImprimir.Image = CType(resources.GetObject("TSBImprimir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBImprimir.Name = "TSBImprimir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBImprimir, "2009")
        Me.TSBImprimir.Size = New System.Drawing.Size(71, 22)
        Me.TSBImprimir.Text = "*&Imprimir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(66, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(53, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'TSBExcel
        '
        Me.TSBExcel.ForeColor = System.Drawing.Color.Black
        Me.TSBExcel.Image = CType(resources.GetObject("TSBExcel.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBExcel, "2500")
        Me.TSBExcel.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBExcel.Name = "TSBExcel"
        Me.COBISResourceProvider.SetResourceID(Me.TSBExcel, "2068")
        Me.TSBExcel.Size = New System.Drawing.Size(58, 22)
        Me.TSBExcel.Text = "*&Excel"
        '
        '_cmdBoton_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_7, False)
        Me._cmdBoton_7.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_7, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_7, True)
        Me._cmdBoton_7.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_7, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_7, Nothing)
        Me._cmdBoton_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_7.Location = New System.Drawing.Point(-630, 145)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_7, System.Drawing.Color.Silver)
        Me._cmdBoton_7.Name = "_cmdBoton_7"
        Me._cmdBoton_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_7.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_7, 1)
        Me._cmdBoton_7.TabIndex = 36
        Me._cmdBoton_7.TabStop = False
        Me._cmdBoton_7.Text = "*&Excel"
        Me._cmdBoton_7.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_7.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_7, "")
        '
        'FHistoricoASClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me._cmdBoton_1)
        Me.Controls.Add(Me._cmdBoton_0)
        Me.Controls.Add(Me._cmdBoton_2)
        Me.Controls.Add(Me._cmdBoton_3)
        Me.Controls.Add(Me._cmdBoton_4)
        Me.Controls.Add(Me._cmdBoton_7)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(147, 167)
        Me.Name = "FHistoricoASClass"
        Me.COBISResourceProvider.SetResourceID(Me, "9918")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(611, 430)
        Me.Tag = "3865"
        Me.Text = "*Histórico de Transacciones de Servicio (Ctas. Ahorros)"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdRegistros_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.GBRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GBRegistros.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(1) = _txtCampo_1
    End Sub
    Sub InitializemskValor()
        Me.mskValor(0) = _mskValor_0
        Me.mskValor(1) = _mskValor_1
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(1) = _lblEtiqueta_1
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(4) = _lblDescripcion_4
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(1) = _lblDescripcion_1
    End Sub
    Sub Initializeil_mascara()
        Me.il_mascara(2) = _il_mascara_2
        Me.il_mascara(6) = _il_mascara_6
        Me.il_mascara(9) = _il_mascara_9
        Me.il_mascara(7) = _il_mascara_7
        Me.il_mascara(8) = _il_mascara_8
        Me.il_mascara(5) = _il_mascara_5
        Me.il_mascara(4) = _il_mascara_4
        Me.il_mascara(1) = _il_mascara_1
        Me.il_mascara(0) = _il_mascara_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(7) = _cmdBoton_7
    End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents grdRegistros_Sheet1 As FarPoint.Win.Spread.SheetView
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBImprimir As System.Windows.Forms.ToolStripButton
    Friend WithEvents GBRegistros As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBExcel As System.Windows.Forms.ToolStripButton
#End Region
End Class



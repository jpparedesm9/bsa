Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FMantenimientoCupoCBClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		isInitializingComponent = True
		InitializeComponent()
		isInitializingComponent = False
		InitializeoptTipoMov()
		InitializelblEtiqueta()
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
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Private WithEvents _optTipoMov_3 As System.Windows.Forms.RadioButton
    Private WithEvents _optTipoMov_0 As System.Windows.Forms.RadioButton
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _optTipoMov_1 As System.Windows.Forms.RadioButton
    Private WithEvents _optTipoMov_2 As System.Windows.Forms.RadioButton
    Public WithEvents mskFecha As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Public WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public WithEvents txtDiasVig As System.Windows.Forms.TextBox
    Public WithEvents fraTipoMov As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents mskCupo As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Public WithEvents Label2 As System.Windows.Forms.Label
    Public WithEvents Label1 As System.Windows.Forms.Label
    Public WithEvents lblCorresponsal As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public WithEvents fraCupo As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Public cmdBoton(4) As System.Windows.Forms.Button
	Public lblEtiqueta(2) As System.Windows.Forms.Label
	Public optTipoMov(3) As System.Windows.Forms.RadioButton
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FMantenimientoCupoCBClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me._optTipoMov_3 = New System.Windows.Forms.RadioButton()
        Me._optTipoMov_0 = New System.Windows.Forms.RadioButton()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._optTipoMov_1 = New System.Windows.Forms.RadioButton()
        Me._optTipoMov_2 = New System.Windows.Forms.RadioButton()
        Me.mskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.fraCupo = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtDiasVig = New System.Windows.Forms.TextBox()
        Me.fraTipoMov = New Infragistics.Win.Misc.UltraGroupBox()
        Me.mskCupo = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.lblCorresponsal = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupRegistros = New Infragistics.Win.Misc.UltraGroupBox()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSiguiente = New System.Windows.Forms.ToolStripButton()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.fraCupo, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraCupo.SuspendLayout()
        CType(Me.fraTipoMov, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.fraTipoMov.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.GroupRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupRegistros.SuspendLayout()
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
        '_optTipoMov_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTipoMov_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTipoMov_3, False)
        Me._optTipoMov_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTipoMov_3, "Default")
        Me._optTipoMov_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTipoMov_3.ForeColor = System.Drawing.Color.Navy
        Me._optTipoMov_3.Location = New System.Drawing.Point(130, 46)
        Me._optTipoMov_3.Name = "_optTipoMov_3"
        Me.COBISResourceProvider.SetResourceID(Me._optTipoMov_3, "508750")
        Me._optTipoMov_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTipoMov_3.Size = New System.Drawing.Size(81, 17)
        Me._optTipoMov_3.TabIndex = 22
        Me._optTipoMov_3.TabStop = True
        Me._optTipoMov_3.Text = "*Vigencia"
        Me._optTipoMov_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTipoMov_3, "")
        '
        '_optTipoMov_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTipoMov_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTipoMov_0, False)
        Me._optTipoMov_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTipoMov_0, "Default")
        Me._optTipoMov_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTipoMov_0.ForeColor = System.Drawing.Color.Navy
        Me._optTipoMov_0.Location = New System.Drawing.Point(9, 22)
        Me._optTipoMov_0.Name = "_optTipoMov_0"
        Me.COBISResourceProvider.SetResourceID(Me._optTipoMov_0, "502816")
        Me._optTipoMov_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTipoMov_0.Size = New System.Drawing.Size(98, 17)
        Me._optTipoMov_0.TabIndex = 4
        Me._optTipoMov_0.TabStop = True
        Me._optTipoMov_0.Text = "*Registro"
        Me._optTipoMov_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTipoMov_0, "")
        '
        'grdRegistros
        '
        Me.grdRegistros._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.grdRegistros.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdRegistros.Clip = ""
        Me.grdRegistros.Col = CType(1, Short)
        Me.grdRegistros.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdRegistros.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "Default")
        Me.grdRegistros.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdRegistros, True)
        Me.grdRegistros.FixedCols = CType(1, Short)
        Me.grdRegistros.FixedRows = CType(1, Short)
        Me.grdRegistros.ForeColor = System.Drawing.Color.Black
        Me.grdRegistros.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdRegistros.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdRegistros.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdRegistros.HighLight = True
        Me.grdRegistros.Location = New System.Drawing.Point(9, 34)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Picture = Nothing
        Me.grdRegistros.Row = CType(1, Short)
        Me.grdRegistros.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdRegistros.Size = New System.Drawing.Size(498, 133)
        Me.grdRegistros.Sort = CType(2, Short)
        Me.grdRegistros.TabIndex = 8
        Me.grdRegistros.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        '_optTipoMov_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTipoMov_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTipoMov_1, False)
        Me._optTipoMov_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTipoMov_1, "Default")
        Me._optTipoMov_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTipoMov_1.ForeColor = System.Drawing.Color.Navy
        Me._optTipoMov_1.Location = New System.Drawing.Point(9, 46)
        Me._optTipoMov_1.Name = "_optTipoMov_1"
        Me.COBISResourceProvider.SetResourceID(Me._optTipoMov_1, "500581")
        Me._optTipoMov_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTipoMov_1.Size = New System.Drawing.Size(98, 17)
        Me._optTipoMov_1.TabIndex = 7
        Me._optTipoMov_1.TabStop = True
        Me._optTipoMov_1.Text = "*Disminución"
        Me._optTipoMov_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTipoMov_1, "")
        '
        '_optTipoMov_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._optTipoMov_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._optTipoMov_2, False)
        Me._optTipoMov_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._optTipoMov_2, "Default")
        Me._optTipoMov_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._optTipoMov_2.ForeColor = System.Drawing.Color.Navy
        Me._optTipoMov_2.Location = New System.Drawing.Point(130, 22)
        Me._optTipoMov_2.Name = "_optTipoMov_2"
        Me.COBISResourceProvider.SetResourceID(Me._optTipoMov_2, "508606")
        Me._optTipoMov_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._optTipoMov_2.Size = New System.Drawing.Size(94, 17)
        Me._optTipoMov_2.TabIndex = 5
        Me._optTipoMov_2.TabStop = True
        Me._optTipoMov_2.Text = "*Incremento"
        Me._optTipoMov_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._optTipoMov_2, "")
        '
        'mskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFecha, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFecha, "Default")
        Me.mskFecha.Length = CType(64, Short)
        Me.mskFecha.Location = New System.Drawing.Point(152, 114)
        Me.mskFecha.Mask = "##/##/####"
        Me.mskFecha.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFecha.MaxReal = 3.402823E+38!
        Me.mskFecha.MinReal = -3.402823E+38!
        Me.mskFecha.Name = "mskFecha"
        Me.mskFecha.Size = New System.Drawing.Size(81, 20)
        Me.mskFecha.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFecha, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(64, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(152, 21)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(123, 20)
        Me.mskCuenta.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
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
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_2.Location = New System.Drawing.Point(-531, 126)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 19
        Me._cmdBoton_2.Text = "&Transmitir"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'fraCupo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraCupo, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraCupo, False)
        Me.fraCupo.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraCupo.Controls.Add(Me.txtDiasVig)
        Me.fraCupo.Controls.Add(Me.fraTipoMov)
        Me.fraCupo.Controls.Add(Me.mskCupo)
        Me.fraCupo.Controls.Add(Me.Label2)
        Me.fraCupo.Controls.Add(Me.lblCorresponsal)
        Me.fraCupo.Controls.Add(Me._lblEtiqueta_2)
        Me.fraCupo.Controls.Add(Me._lblEtiqueta_1)
        Me.fraCupo.Controls.Add(Me.mskCuenta)
        Me.fraCupo.Controls.Add(Me.mskFecha)
        Me.fraCupo.Controls.Add(Me._lblEtiqueta_0)
        Me.fraCupo.Controls.Add(Me.Label1)
        Me.COBISStyleProvider.SetControlStyle(Me.fraCupo, "Default")
        Me.fraCupo.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.fraCupo.ForeColor = System.Drawing.Color.Navy
        Me.fraCupo.Location = New System.Drawing.Point(10, 10)
        Me.fraCupo.Name = "fraCupo"
        Me.COBISResourceProvider.SetResourceID(Me.fraCupo, "508699")
        Me.fraCupo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraCupo.Size = New System.Drawing.Size(519, 145)
        Me.fraCupo.TabIndex = 0
        Me.fraCupo.Text = "*Registro de Cupo del Corresponsal"
        Me.fraCupo.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraCupo, "")
        '
        'txtDiasVig
        '
        Me.txtDiasVig.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtDiasVig, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtDiasVig, False)
        Me.txtDiasVig.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtDiasVig, "Default")
        Me.txtDiasVig.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtDiasVig.Location = New System.Drawing.Point(152, 91)
        Me.txtDiasVig.MaxLength = 4
        Me.txtDiasVig.Name = "txtDiasVig"
        Me.txtDiasVig.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtDiasVig.Size = New System.Drawing.Size(65, 20)
        Me.txtDiasVig.TabIndex = 3
        Me.txtDiasVig.Text = "0"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtDiasVig, "")
        '
        'fraTipoMov
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.fraTipoMov, False)
        Me.COBISViewResizer.SetAutoResize(Me.fraTipoMov, False)
        Me.fraTipoMov.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.fraTipoMov.Controls.Add(Me._optTipoMov_2)
        Me.fraTipoMov.Controls.Add(Me._optTipoMov_3)
        Me.fraTipoMov.Controls.Add(Me._optTipoMov_1)
        Me.fraTipoMov.Controls.Add(Me._optTipoMov_0)
        Me.COBISStyleProvider.SetControlStyle(Me.fraTipoMov, "Default")
        Me.fraTipoMov.ForeColor = System.Drawing.Color.Navy
        Me.fraTipoMov.Location = New System.Drawing.Point(283, 70)
        Me.fraTipoMov.Name = "fraTipoMov"
        Me.COBISResourceProvider.SetResourceID(Me.fraTipoMov, "508727")
        Me.fraTipoMov.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.fraTipoMov.Size = New System.Drawing.Size(230, 73)
        Me.fraTipoMov.TabIndex = 13
        Me.fraTipoMov.Text = "*Tipo de Movimiento"
        Me.fraTipoMov.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.fraTipoMov, "")
        '
        'mskCupo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCupo, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCupo, False)
        Me.mskCupo.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskCupo.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskCupo, "Default")
        Me.mskCupo.Cuantas = 0
        Me.mskCupo.DateString = ""
        Me.mskCupo.DateSybase = "12/16/13"
        Me.mskCupo.Decimals = CType(2, Short)
        Me.mskCupo.Errores = CType(0, Short)
        Me.mskCupo.Fin = 0
        Me.mskCupo.FormattedText = ""
        Me.mskCupo.HelpLine = ""
        Me.mskCupo.HideSelection = False
        Me.mskCupo.hWnd = 0
        Me.mskCupo.Location = New System.Drawing.Point(152, 68)
        Me.mskCupo.Mask = Nothing
        Me.mskCupo.MaxLength = 0
        Me.mskCupo.MaxReal = 3.4E+38!
        Me.mskCupo.MinReal = -1.1E+38!
        Me.mskCupo.Name = "mskCupo"
        Me.mskCupo.Nullable = False
        Me.mskCupo.Separator = True
        Me.mskCupo.Size = New System.Drawing.Size(121, 20)
        Me.mskCupo.StringIndex = CType(0, Short)
        Me.mskCupo.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCupo, "")
        '
        'Label2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label2, False)
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label2, "Default")
        Me.Label2.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label2.ForeColor = System.Drawing.Color.Navy
        Me.Label2.Location = New System.Drawing.Point(10, 91)
        Me.Label2.Name = "Label2"
        Me.COBISResourceProvider.SetResourceID(Me.Label2, "508531")
        Me.Label2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label2.Size = New System.Drawing.Size(122, 20)
        Me.Label2.TabIndex = 15
        Me.Label2.Text = "*Días de Vigencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label2, "")
        '
        'lblCorresponsal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCorresponsal, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCorresponsal, False)
        Me.lblCorresponsal.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblCorresponsal.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblCorresponsal, "Default")
        Me.lblCorresponsal.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCorresponsal.Location = New System.Drawing.Point(152, 45)
        Me.lblCorresponsal.Name = "lblCorresponsal"
        Me.lblCorresponsal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCorresponsal.Size = New System.Drawing.Size(355, 19)
        Me.lblCorresponsal.TabIndex = 12
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCorresponsal, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(10, 68)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "508494")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(105, 20)
        Me._lblEtiqueta_2.TabIndex = 11
        Me._lblEtiqueta_2.Text = "*Cupo:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(10, 45)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "500334")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(113, 20)
        Me._lblEtiqueta_1.TabIndex = 10
        Me._lblEtiqueta_1.Text = "*Corresponsal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 22)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501874")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(148, 20)
        Me._lblEtiqueta_0.TabIndex = 9
        Me._lblEtiqueta_0.Text = "*No. de Cuenta Ahorros:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.Cursor = System.Windows.Forms.Cursors.Default
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(10, 114)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "508579")
        Me.Label1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Label1.Size = New System.Drawing.Size(148, 20)
        Me.Label1.TabIndex = 14
        Me.Label1.Text = "*Fecha de Vencimiento:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
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
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_0.Location = New System.Drawing.Point(-531, 14)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 17
        Me._cmdBoton_0.Tag = "388;389"
        Me._cmdBoton_0.Text = "&Buscar"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_1.Location = New System.Drawing.Point(-531, 70)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 18
        Me._cmdBoton_1.Tag = "388;389"
        Me._cmdBoton_1.Text = "Si&guiente"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
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
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_3.Location = New System.Drawing.Point(-531, 246)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 20
        Me._cmdBoton_3.Text = "&Limpiar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Image = CType(resources.GetObject("_cmdBoton_4.Image"), System.Drawing.Image)
        Me._cmdBoton_4.ImageAlign = System.Drawing.ContentAlignment.TopCenter
        Me._cmdBoton_4.Location = New System.Drawing.Point(-531, 302)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(61, 55)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 21
        Me._cmdBoton_4.Text = "&Salir"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.fraCupo)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_0)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me.GroupRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 28)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(537, 386)
        Me.PFormas.TabIndex = 24
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'GroupRegistros
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupRegistros, False)
        Me.GroupRegistros.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupRegistros.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupRegistros, "Default")
        Me.GroupRegistros.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold)
        Me.GroupRegistros.ForeColor = System.Drawing.Color.Navy
        Me.GroupRegistros.Location = New System.Drawing.Point(10, 161)
        Me.GroupRegistros.Name = "GroupRegistros"
        Me.COBISResourceProvider.SetResourceID(Me.GroupRegistros, "502816")
        Me.GroupRegistros.Size = New System.Drawing.Size(519, 210)
        Me.GroupRegistros.TabIndex = 24
        Me.GroupRegistros.Text = "*Registros"
        Me.GroupRegistros.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupRegistros, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBSiguiente, Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(547, 25)
        Me.TSBotones.TabIndex = 25
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Navy
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBSiguiente
        '
        Me.TSBSiguiente.ForeColor = System.Drawing.Color.Navy
        Me.TSBSiguiente.Image = CType(resources.GetObject("TSBSiguiente.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSiguiente, "2001")
        Me.TSBSiguiente.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSiguiente.Name = "TSBSiguiente"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSiguiente, "500012")
        Me.TSBSiguiente.Size = New System.Drawing.Size(81, 22)
        Me.TSBSiguiente.Text = "*Siguien&te"
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Navy
        Me.TSBTransmitir.Image = CType(resources.GetObject("TSBTransmitir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBTransmitir.Name = "TSBTransmitir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBTransmitir, "2007")
        Me.TSBTransmitir.Size = New System.Drawing.Size(86, 22)
        Me.TSBTransmitir.Text = "*&Transmitir"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Navy
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "2003")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.ForeColor = System.Drawing.Color.Navy
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'FMantenimientoCupoCBClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.TSBotones)
        Me.Controls.Add(Me.PFormas)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(4, 30)
        Me.Name = "FMantenimientoCupoCBClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(547, 414)
        Me.Text = "Mantenimiento Cupo Corresponsal Bancario Red Posicionada "
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.fraCupo, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraCupo.ResumeLayout(False)
        Me.fraCupo.PerformLayout()
        CType(Me.fraTipoMov, System.ComponentModel.ISupportInitialize).EndInit()
        Me.fraTipoMov.ResumeLayout(False)
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.GroupRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupRegistros.ResumeLayout(False)
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializeoptTipoMov()
        Me.optTipoMov(3) = _optTipoMov_3
        Me.optTipoMov(0) = _optTipoMov_0
        Me.optTipoMov(1) = _optTipoMov_1
        Me.optTipoMov(2) = _optTipoMov_2
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupRegistros As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSiguiente As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
#End Region 
End Class



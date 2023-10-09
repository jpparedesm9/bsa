Imports COBISCorp.tCOBIS.PER.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
 Partial   Class FParComClass
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		'This call is required by the Windows Form Designer.
		InitializeComponent()
		InitializetxtCampo()
		InitializelblEtiqueta()
		InitializelblDescripcion()
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
    Public WithEvents grdParamCobCom As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents Frame3 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_0 As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Private WithEvents _cmdBoton_8 As System.Windows.Forms.Button
    Public WithEvents txtNumTrn As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Private WithEvents _cmdBoton_6 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_7 As System.Windows.Forms.Button
    Public WithEvents txtCanal As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents txtCausal As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents lblDesEstado As System.Windows.Forms.Label
    Public WithEvents lblEstado As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_16 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_15 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_13 As System.Windows.Forms.Label
    Public WithEvents lblDesCausal As System.Windows.Forms.Label
    Public WithEvents lblDesCanal As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_11 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Public WithEvents FraTransaccion As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdParamTrans As COBISCorp.Framework.UI.Components.COBISGrid
    Public WithEvents Frame4 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _txtCampo_2 As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Private WithEvents _txtCampo_3 As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Private WithEvents _txtCampo_1 As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_2 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_9 As System.Windows.Forms.Label
    Public WithEvents Frame2 As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents cmbEstado As System.Windows.Forms.ComboBox
    Public WithEvents mskFecha As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents _txtCampo_4 As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents txtTotTrans As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents txtDebito As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents txtCredito As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Public WithEvents txtConsulta As COBISCorp.Framework.UI.Components.COBISValidTextBox
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_12 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_8 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_7 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_4 As System.Windows.Forms.Label
    Public WithEvents Frame1 As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_0 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_1 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_5 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Public WithEvents OLE1 As System.Windows.Forms.Label
    Public cmdBoton(8) As System.Windows.Forms.Button
	Public lblDescripcion(4) As System.Windows.Forms.Label
	Public lblEtiqueta(16) As System.Windows.Forms.Label
	Public txtCampo(4) As COBISCorp.Framework.UI.Components.COBISValidTextBox
	Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> _
	 Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FParComClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.Frame3 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdParamCobCom = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.FraTransaccion = New Infragistics.Win.Misc.UltraGroupBox()
        Me.mskMonto = New COBISCorp.Framework.UI.Components.CobisRealInput()
        Me._txtCampo_0 = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._cmdBoton_8 = New System.Windows.Forms.Button()
        Me.txtNumTrn = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._cmdBoton_6 = New System.Windows.Forms.Button()
        Me._cmdBoton_7 = New System.Windows.Forms.Button()
        Me.txtCanal = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtCausal = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.lblDesEstado = New System.Windows.Forms.Label()
        Me.lblEstado = New System.Windows.Forms.Label()
        Me._lblEtiqueta_16 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_15 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_13 = New System.Windows.Forms.Label()
        Me.lblDesCausal = New System.Windows.Forms.Label()
        Me.lblDesCanal = New System.Windows.Forms.Label()
        Me._lblEtiqueta_11 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me.Frame4 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdParamTrans = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me.OLE1 = New System.Windows.Forms.Label()
        Me.Frame2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me._txtCampo_2 = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._txtCampo_3 = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._txtCampo_1 = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_2 = New System.Windows.Forms.Label()
        Me._lblDescripcion_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_9 = New System.Windows.Forms.Label()
        Me.Frame1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.cmbEstado = New System.Windows.Forms.ComboBox()
        Me.mskFecha = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me._txtCampo_4 = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtTotTrans = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtDebito = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtCredito = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me.txtConsulta = New COBISCorp.Framework.UI.Components.COBISValidTextBox()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_12 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_8 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_7 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me._lblDescripcion_4 = New System.Windows.Forms.Label()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_0 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._cmdBoton_1 = New System.Windows.Forms.Button()
        Me._cmdBoton_5 = New System.Windows.Forms.Button()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBCrear = New System.Windows.Forms.ToolStripButton()
        Me.TSBActualizar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.Pforma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame3.SuspendLayout()
        CType(Me.grdParamCobCom, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.FraTransaccion, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.FraTransaccion.SuspendLayout()
        CType(Me.Frame4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame4.SuspendLayout()
        CType(Me.grdParamTrans, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame2.SuspendLayout()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Frame1.SuspendLayout()
        Me.TSBotones.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.Pforma.SuspendLayout()
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
        'Frame3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame3, False)
        Me.Frame3.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame3.Controls.Add(Me.grdParamCobCom)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame3, "Default")
        Me.Frame3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame3.ForeColor = System.Drawing.Color.Navy
        Me.Frame3.Location = New System.Drawing.Point(10, 210)
        Me.Frame3.Name = "Frame3"
        Me.COBISResourceProvider.SetResourceID(Me.Frame3, "1215")
        Me.Frame3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame3.Size = New System.Drawing.Size(560, 97)
        Me.Frame3.TabIndex = 52
        Me.Frame3.Text = "*Detalle Cobro Comisión:"
        Me.Frame3.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame3, "")
        '
        'grdParamCobCom
        '
        Me.grdParamCobCom._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdParamCobCom, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdParamCobCom, False)
        Me.grdParamCobCom.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdParamCobCom.Clip = ""
        Me.grdParamCobCom.Col = CType(1, Short)
        Me.grdParamCobCom.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdParamCobCom.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdParamCobCom.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdParamCobCom, "Default")
        Me.grdParamCobCom.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdParamCobCom, True)
        Me.grdParamCobCom.FixedCols = CType(1, Short)
        Me.grdParamCobCom.FixedRows = CType(1, Short)
        Me.grdParamCobCom.ForeColor = System.Drawing.Color.Black
        Me.grdParamCobCom.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdParamCobCom.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdParamCobCom.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdParamCobCom.HighLight = True
        Me.grdParamCobCom.Location = New System.Drawing.Point(8, 19)
        Me.grdParamCobCom.Name = "grdParamCobCom"
        Me.grdParamCobCom.Picture = Nothing
        Me.grdParamCobCom.Row = CType(1, Short)
        Me.grdParamCobCom.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdParamCobCom.Size = New System.Drawing.Size(539, 73)
        Me.grdParamCobCom.Sort = CType(2, Short)
        Me.grdParamCobCom.TabIndex = 10
        Me.grdParamCobCom.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdParamCobCom, "")
        '
        'FraTransaccion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.FraTransaccion, False)
        Me.COBISViewResizer.SetAutoResize(Me.FraTransaccion, False)
        Me.FraTransaccion.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.FraTransaccion.Controls.Add(Me.mskMonto)
        Me.FraTransaccion.Controls.Add(Me._txtCampo_0)
        Me.FraTransaccion.Controls.Add(Me._cmdBoton_8)
        Me.FraTransaccion.Controls.Add(Me.txtNumTrn)
        Me.FraTransaccion.Controls.Add(Me._cmdBoton_6)
        Me.FraTransaccion.Controls.Add(Me._cmdBoton_7)
        Me.FraTransaccion.Controls.Add(Me.txtCanal)
        Me.FraTransaccion.Controls.Add(Me.txtCausal)
        Me.FraTransaccion.Controls.Add(Me.lblDesEstado)
        Me.FraTransaccion.Controls.Add(Me.lblEstado)
        Me.FraTransaccion.Controls.Add(Me._lblEtiqueta_16)
        Me.FraTransaccion.Controls.Add(Me._lblEtiqueta_15)
        Me.FraTransaccion.Controls.Add(Me._lblEtiqueta_13)
        Me.FraTransaccion.Controls.Add(Me.lblDesCausal)
        Me.FraTransaccion.Controls.Add(Me.lblDesCanal)
        Me.FraTransaccion.Controls.Add(Me._lblEtiqueta_11)
        Me.FraTransaccion.Controls.Add(Me._lblEtiqueta_10)
        Me.FraTransaccion.Controls.Add(Me._lblDescripcion_0)
        Me.FraTransaccion.Controls.Add(Me._lblEtiqueta_4)
        Me.COBISStyleProvider.SetControlStyle(Me.FraTransaccion, "Default")
        Me.FraTransaccion.Enabled = False
        Me.FraTransaccion.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.FraTransaccion.ForeColor = System.Drawing.Color.Navy
        Me.FraTransaccion.Location = New System.Drawing.Point(10, 309)
        Me.FraTransaccion.Name = "FraTransaccion"
        Me.COBISResourceProvider.SetResourceID(Me.FraTransaccion, "1410")
        Me.FraTransaccion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.FraTransaccion.Size = New System.Drawing.Size(560, 119)
        Me.FraTransaccion.TabIndex = 53
        Me.FraTransaccion.Text = "*Información Comisión por Transacción:"
        Me.FraTransaccion.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.FraTransaccion, "")
        '
        'mskMonto
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskMonto, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskMonto, False)
        Me.mskMonto.BackColor = System.Drawing.SystemColors.Window
        Me.mskMonto.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskMonto, "Default")
        Me.mskMonto.DecimalPlaces = 2
        Me.mskMonto.Location = New System.Drawing.Point(213, 89)
        Me.mskMonto.MaxLength = 17
        Me.mskMonto.MaxReal = 0.0!
        Me.mskMonto.MinReal = 0.0!
        Me.mskMonto.Name = "mskMonto"
        Me.mskMonto.Separator = True
        Me.mskMonto.Size = New System.Drawing.Size(72, 20)
        Me.mskMonto.TabIndex = 36
        Me.mskMonto.Text = "0.00"
        Me.mskMonto.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.mskMonto.ValueDouble = 0.0R
        Me.mskMonto.ValueReal = 0.0!
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskMonto, "")
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Control
        Me._txtCampo_0.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me._txtCampo_0, True)
        Me._txtCampo_0.Error = CType(0, Short)
        Me._txtCampo_0.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_0.HelpLine = Nothing
        Me._txtCampo_0.Location = New System.Drawing.Point(107, 42)
        Me._txtCampo_0.MaxLength = CType(4, Short)
        Me._txtCampo_0.MinChar = CType(0, Short)
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.Pendiente = Nothing
        Me._txtCampo_0.Range = Nothing
        Me._txtCampo_0.Size = New System.Drawing.Size(48, 20)
        Me._txtCampo_0.TabIndex = 29
        Me._txtCampo_0.TableName = Nothing
        Me._txtCampo_0.Tag = "12"
        Me._txtCampo_0.TitleCatalog = Nothing
        Me._txtCampo_0.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_cmdBoton_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_8, False)
        Me._cmdBoton_8.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_8, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_8, True)
        Me._cmdBoton_8.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_8, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_8, Nothing)
        Me._cmdBoton_8.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_8.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_8.Location = New System.Drawing.Point(464, 61)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_8, System.Drawing.Color.Silver)
        Me._cmdBoton_8.Name = "_cmdBoton_8"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_8, "1311")
        Me._cmdBoton_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_8.Size = New System.Drawing.Size(83, 19)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_8, 1)
        Me._cmdBoton_8.TabIndex = 43
        Me._cmdBoton_8.Tag = "4109"
        Me._cmdBoton_8.Text = "*Eli&minar"
        Me._cmdBoton_8.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_8.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_8, "")
        '
        'txtNumTrn
        '
        Me.txtNumTrn.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNumTrn, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNumTrn, False)
        Me.txtNumTrn.BackColor = System.Drawing.SystemColors.Control
        Me.txtNumTrn.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtNumTrn, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtNumTrn, True)
        Me.txtNumTrn.Error = CType(0, Short)
        Me.txtNumTrn.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtNumTrn.HelpLine = Nothing
        Me.txtNumTrn.Location = New System.Drawing.Point(107, 88)
        Me.txtNumTrn.MaxLength = CType(3, Short)
        Me.txtNumTrn.MinChar = CType(0, Short)
        Me.txtNumTrn.Name = "txtNumTrn"
        Me.txtNumTrn.Pendiente = Nothing
        Me.txtNumTrn.Range = Nothing
        Me.txtNumTrn.Size = New System.Drawing.Size(48, 20)
        Me.txtNumTrn.TabIndex = 35
        Me.txtNumTrn.TableName = Nothing
        Me.txtNumTrn.Tag = "14"
        Me.txtNumTrn.TitleCatalog = Nothing
        Me.txtNumTrn.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNumTrn, "")
        '
        '_cmdBoton_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_6, False)
        Me._cmdBoton_6.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_6, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_6, True)
        Me._cmdBoton_6.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_6, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_6, Nothing)
        Me._cmdBoton_6.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_6.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_6.Location = New System.Drawing.Point(464, 20)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_6, System.Drawing.Color.Silver)
        Me._cmdBoton_6.Name = "_cmdBoton_6"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_6, "1041")
        Me._cmdBoton_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_6.Size = New System.Drawing.Size(83, 19)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_6, 1)
        Me._cmdBoton_6.TabIndex = 41
        Me._cmdBoton_6.Tag = "4109"
        Me._cmdBoton_6.Text = "*C&rear"
        Me._cmdBoton_6.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_6.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_6, "")
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
        Me._cmdBoton_7.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_7.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_7.Location = New System.Drawing.Point(464, 40)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_7, System.Drawing.Color.Silver)
        Me._cmdBoton_7.Name = "_cmdBoton_7"
        Me.COBISResourceProvider.SetResourceID(Me._cmdBoton_7, "1010")
        Me._cmdBoton_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_7.Size = New System.Drawing.Size(83, 19)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_7, 1)
        Me._cmdBoton_7.TabIndex = 42
        Me._cmdBoton_7.Tag = "4109"
        Me._cmdBoton_7.Text = "*Ac&tualizar"
        Me._cmdBoton_7.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_7.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_7, "")
        '
        'txtCanal
        '
        Me.txtCanal.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCanal, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCanal, False)
        Me.txtCanal.BackColor = System.Drawing.SystemColors.Control
        Me.txtCanal.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtCanal, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtCanal, True)
        Me.txtCanal.Error = CType(0, Short)
        Me.txtCanal.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCanal.HelpLine = Nothing
        Me.txtCanal.Location = New System.Drawing.Point(107, 20)
        Me.txtCanal.MaxLength = CType(4, Short)
        Me.txtCanal.MinChar = CType(0, Short)
        Me.txtCanal.Name = "txtCanal"
        Me.txtCanal.Pendiente = Nothing
        Me.txtCanal.Range = Nothing
        Me.txtCanal.Size = New System.Drawing.Size(48, 20)
        Me.txtCanal.TabIndex = 26
        Me.txtCanal.TableName = Nothing
        Me.txtCanal.Tag = "11"
        Me.txtCanal.TitleCatalog = Nothing
        Me.txtCanal.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCanal, "")
        '
        'txtCausal
        '
        Me.txtCausal.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCausal, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCausal, False)
        Me.txtCausal.BackColor = System.Drawing.SystemColors.Control
        Me.txtCausal.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtCausal, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me.txtCausal, True)
        Me.txtCausal.Error = CType(0, Short)
        Me.txtCausal.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCausal.HelpLine = Nothing
        Me.txtCausal.Location = New System.Drawing.Point(107, 65)
        Me.txtCausal.MaxLength = CType(4, Short)
        Me.txtCausal.MinChar = CType(0, Short)
        Me.txtCausal.Name = "txtCausal"
        Me.txtCausal.Pendiente = Nothing
        Me.txtCausal.Range = Nothing
        Me.txtCausal.Size = New System.Drawing.Size(48, 20)
        Me.txtCausal.TabIndex = 32
        Me.txtCausal.TableName = Nothing
        Me.txtCausal.Tag = "13"
        Me.txtCausal.TitleCatalog = Nothing
        Me.txtCausal.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCausal, "")
        '
        'lblDesEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDesEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDesEstado, False)
        Me.lblDesEstado.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDesEstado.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDesEstado, "Default")
        Me.lblDesEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDesEstado.Location = New System.Drawing.Point(387, 88)
        Me.lblDesEstado.Name = "lblDesEstado"
        Me.lblDesEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDesEstado.Size = New System.Drawing.Size(74, 20)
        Me.lblDesEstado.TabIndex = 40
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDesEstado, "")
        '
        'lblEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblEstado, False)
        Me.lblEstado.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblEstado.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblEstado, "Default")
        Me.lblEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblEstado.Location = New System.Drawing.Point(348, 88)
        Me.lblEstado.Name = "lblEstado"
        Me.lblEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblEstado.Size = New System.Drawing.Size(37, 20)
        Me.lblEstado.TabIndex = 39
        Me.lblEstado.Tag = "16"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblEstado, "")
        '
        '_lblEtiqueta_16
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_16, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_16, False)
        Me._lblEtiqueta_16.AutoSize = True
        Me._lblEtiqueta_16.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_16, "Default")
        Me._lblEtiqueta_16.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_16.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_16.Location = New System.Drawing.Point(291, 88)
        Me._lblEtiqueta_16.Name = "_lblEtiqueta_16"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_16, "1340")
        Me._lblEtiqueta_16.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_16.Size = New System.Drawing.Size(55, 13)
        Me._lblEtiqueta_16.TabIndex = 38
        Me._lblEtiqueta_16.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_16, "")
        '
        '_lblEtiqueta_15
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_15, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_15, False)
        Me._lblEtiqueta_15.AutoSize = True
        Me._lblEtiqueta_15.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_15, "Default")
        Me._lblEtiqueta_15.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_15.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_15.Location = New System.Drawing.Point(163, 88)
        Me._lblEtiqueta_15.Name = "_lblEtiqueta_15"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_15, "1489")
        Me._lblEtiqueta_15.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_15.Size = New System.Drawing.Size(51, 13)
        Me._lblEtiqueta_15.TabIndex = 36
        Me._lblEtiqueta_15.Text = "*Monto:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_15, "")
        '
        '_lblEtiqueta_13
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_13, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_13, False)
        Me._lblEtiqueta_13.AutoSize = True
        Me._lblEtiqueta_13.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_13, "Default")
        Me._lblEtiqueta_13.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_13.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_13.Location = New System.Drawing.Point(8, 65)
        Me._lblEtiqueta_13.Name = "_lblEtiqueta_13"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_13, "1075")
        Me._lblEtiqueta_13.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_13.Size = New System.Drawing.Size(54, 13)
        Me._lblEtiqueta_13.TabIndex = 31
        Me._lblEtiqueta_13.Text = "*Causal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_13, "")
        '
        'lblDesCausal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDesCausal, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDesCausal, False)
        Me.lblDesCausal.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDesCausal.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDesCausal, "Default")
        Me.lblDesCausal.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDesCausal.Location = New System.Drawing.Point(157, 65)
        Me.lblDesCausal.Name = "lblDesCausal"
        Me.lblDesCausal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDesCausal.Size = New System.Drawing.Size(304, 20)
        Me.lblDesCausal.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDesCausal, "")
        '
        'lblDesCanal
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblDesCanal, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblDesCanal, False)
        Me.lblDesCanal.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblDesCanal.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblDesCanal, "Default")
        Me.lblDesCanal.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblDesCanal.Location = New System.Drawing.Point(157, 20)
        Me.lblDesCanal.Name = "lblDesCanal"
        Me.lblDesCanal.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblDesCanal.Size = New System.Drawing.Size(304, 20)
        Me.lblDesCanal.TabIndex = 27
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblDesCanal, "")
        '
        '_lblEtiqueta_11
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_11, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_11, False)
        Me._lblEtiqueta_11.AutoSize = True
        Me._lblEtiqueta_11.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_11, "Default")
        Me._lblEtiqueta_11.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_11.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_11.Location = New System.Drawing.Point(8, 20)
        Me._lblEtiqueta_11.Name = "_lblEtiqueta_11"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_11, "1043")
        Me._lblEtiqueta_11.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_11.Size = New System.Drawing.Size(48, 13)
        Me._lblEtiqueta_11.TabIndex = 25
        Me._lblEtiqueta_11.Text = "*Canal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_11, "")
        '
        '_lblEtiqueta_10
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.AutoSize = True
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(8, 88)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "1056")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(93, 13)
        Me._lblEtiqueta_10.TabIndex = 34
        Me._lblEtiqueta_10.Text = "*Cantidad Trn.:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblDescripcion_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_0, False)
        Me._lblDescripcion_0.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_0.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_0, "Default")
        Me._lblDescripcion_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_0.Location = New System.Drawing.Point(157, 42)
        Me._lblDescripcion_0.Name = "_lblDescripcion_0"
        Me._lblDescripcion_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_0.Size = New System.Drawing.Size(304, 20)
        Me._lblDescripcion_0.TabIndex = 30
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_0, "")
        '
        '_lblEtiqueta_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.AutoSize = True
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(8, 42)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "1792")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(86, 13)
        Me._lblEtiqueta_4.TabIndex = 28
        Me._lblEtiqueta_4.Text = "*Transacción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        'Frame4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame4, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame4, False)
        Me.Frame4.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame4.Controls.Add(Me.grdParamTrans)
        Me.Frame4.Controls.Add(Me.OLE1)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame4, "Default")
        Me.Frame4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame4.ForeColor = System.Drawing.Color.Navy
        Me.Frame4.Location = New System.Drawing.Point(10, 436)
        Me.Frame4.Name = "Frame4"
        Me.COBISResourceProvider.SetResourceID(Me.Frame4, "1216")
        Me.Frame4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame4.Size = New System.Drawing.Size(560, 103)
        Me.Frame4.TabIndex = 53
        Me.Frame4.Text = "*Detalle Cobro Comisión por Transacción:"
        Me.Frame4.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame4, "")
        '
        'grdParamTrans
        '
        Me.grdParamTrans._Text = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdParamTrans, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdParamTrans, False)
        Me.grdParamTrans.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdParamTrans.Clip = ""
        Me.grdParamTrans.Col = CType(1, Short)
        Me.grdParamTrans.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdParamTrans.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdParamTrans.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.COBISStyleProvider.SetControlStyle(Me.grdParamTrans, "Default")
        Me.grdParamTrans.CtlText = ""
        Me.COBISStyleProvider.SetEnableStyle(Me.grdParamTrans, True)
        Me.grdParamTrans.FixedCols = CType(1, Short)
        Me.grdParamTrans.FixedRows = CType(1, Short)
        Me.grdParamTrans.ForeColor = System.Drawing.Color.Black
        Me.grdParamTrans.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdParamTrans.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdParamTrans.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdParamTrans.HighLight = True
        Me.grdParamTrans.Location = New System.Drawing.Point(8, 16)
        Me.grdParamTrans.Name = "grdParamTrans"
        Me.grdParamTrans.Picture = Nothing
        Me.grdParamTrans.Row = CType(1, Short)
        Me.grdParamTrans.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdParamTrans.Size = New System.Drawing.Size(539, 81)
        Me.grdParamTrans.Sort = CType(2, Short)
        Me.grdParamTrans.TabIndex = 45
        Me.grdParamTrans.TopRow = CType(1, Short)
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdParamTrans, "")
        '
        'OLE1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.OLE1, False)
        Me.COBISViewResizer.SetAutoResize(Me.OLE1, False)
        Me.OLE1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.OLE1, "Default")
        Me.OLE1.ForeColor = System.Drawing.Color.Navy
        Me.OLE1.Location = New System.Drawing.Point(398, 61)
        Me.OLE1.Name = "OLE1"
        Me.OLE1.Size = New System.Drawing.Size(193, 87)
        Me.OLE1.TabIndex = 56
        Me.OLE1.Text = "OLE1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.OLE1, "")
        '
        'Frame2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame2, False)
        Me.Frame2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame2.Controls.Add(Me._txtCampo_2)
        Me.Frame2.Controls.Add(Me._txtCampo_3)
        Me.Frame2.Controls.Add(Me._txtCampo_1)
        Me.Frame2.Controls.Add(Me._lblDescripcion_1)
        Me.Frame2.Controls.Add(Me._lblDescripcion_2)
        Me.Frame2.Controls.Add(Me._lblDescripcion_3)
        Me.Frame2.Controls.Add(Me._lblEtiqueta_0)
        Me.Frame2.Controls.Add(Me._lblEtiqueta_3)
        Me.Frame2.Controls.Add(Me._lblEtiqueta_9)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame2, "Default")
        Me.Frame2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame2.ForeColor = System.Drawing.Color.Navy
        Me.Frame2.Location = New System.Drawing.Point(10, 6)
        Me.Frame2.Name = "Frame2"
        Me.COBISResourceProvider.SetResourceID(Me.Frame2, "1411")
        Me.Frame2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame2.Size = New System.Drawing.Size(560, 85)
        Me.Frame2.TabIndex = 29
        Me.Frame2.Text = "*Información Producto"
        Me.Frame2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame2, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Control
        Me._txtCampo_2.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me._txtCampo_2, True)
        Me._txtCampo_2.Error = CType(0, Short)
        Me._txtCampo_2.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_2.HelpLine = Nothing
        Me._txtCampo_2.Location = New System.Drawing.Point(135, 38)
        Me._txtCampo_2.MaxLength = CType(4, Short)
        Me._txtCampo_2.MinChar = CType(0, Short)
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.Pendiente = Nothing
        Me._txtCampo_2.Range = Nothing
        Me._txtCampo_2.Size = New System.Drawing.Size(73, 20)
        Me._txtCampo_2.TabIndex = 1
        Me._txtCampo_2.TableName = Nothing
        Me._txtCampo_2.Tag = "2"
        Me._txtCampo_2.TitleCatalog = Nothing
        Me._txtCampo_2.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Control
        Me._txtCampo_3.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me._txtCampo_3, True)
        Me._txtCampo_3.Error = CType(0, Short)
        Me._txtCampo_3.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_3.HelpLine = Nothing
        Me._txtCampo_3.Location = New System.Drawing.Point(135, 60)
        Me._txtCampo_3.MaxLength = CType(3, Short)
        Me._txtCampo_3.MinChar = CType(0, Short)
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.Pendiente = Nothing
        Me._txtCampo_3.Range = Nothing
        Me._txtCampo_3.Size = New System.Drawing.Size(73, 20)
        Me._txtCampo_3.TabIndex = 2
        Me._txtCampo_3.TableName = Nothing
        Me._txtCampo_3.Tag = "3"
        Me._txtCampo_3.TitleCatalog = Nothing
        Me._txtCampo_3.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Alpabetic
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_1
        '
        Me._txtCampo_1.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_1, False)
        Me._txtCampo_1.BackColor = System.Drawing.SystemColors.Control
        Me._txtCampo_1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_1, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me._txtCampo_1, True)
        Me._txtCampo_1.Error = CType(0, Short)
        Me._txtCampo_1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_1.HelpLine = Nothing
        Me._txtCampo_1.Location = New System.Drawing.Point(135, 16)
        Me._txtCampo_1.MaxLength = CType(4, Short)
        Me._txtCampo_1.MinChar = CType(0, Short)
        Me._txtCampo_1.Name = "_txtCampo_1"
        Me._txtCampo_1.Pendiente = Nothing
        Me._txtCampo_1.Range = Nothing
        Me._txtCampo_1.Size = New System.Drawing.Size(73, 20)
        Me._txtCampo_1.TabIndex = 0
        Me._txtCampo_1.TableName = Nothing
        Me._txtCampo_1.Tag = "1"
        Me._txtCampo_1.TitleCatalog = Nothing
        Me._txtCampo_1.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Int
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_1, "")
        '
        '_lblDescripcion_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(209, 16)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(338, 20)
        Me._lblDescripcion_1.TabIndex = 2
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblDescripcion_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_2, False)
        Me._lblDescripcion_2.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_2.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_2, "Default")
        Me._lblDescripcion_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_2.Location = New System.Drawing.Point(209, 38)
        Me._lblDescripcion_2.Name = "_lblDescripcion_2"
        Me._lblDescripcion_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_2.Size = New System.Drawing.Size(338, 20)
        Me._lblDescripcion_2.TabIndex = 5
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_2, "")
        '
        '_lblDescripcion_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_3, False)
        Me._lblDescripcion_3.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_3.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_3, "Default")
        Me._lblDescripcion_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_3.Location = New System.Drawing.Point(209, 60)
        Me._lblDescripcion_3.Name = "_lblDescripcion_3"
        Me._lblDescripcion_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_3.Size = New System.Drawing.Size(338, 20)
        Me._lblDescripcion_3.TabIndex = 8
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_3, "")
        '
        '_lblEtiqueta_0
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.AutoSize = True
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(8, 16)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "1738")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(65, 13)
        Me._lblEtiqueta_0.TabIndex = 0
        Me._lblEtiqueta_0.Text = "*Sucursal:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        '_lblEtiqueta_3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.AutoSize = True
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(8, 38)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "1668")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(98, 13)
        Me._lblEtiqueta_3.TabIndex = 3
        Me._lblEtiqueta_3.Text = "*Producto Final:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_9
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_9, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_9, False)
        Me._lblEtiqueta_9.AutoSize = True
        Me._lblEtiqueta_9.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_9, "Default")
        Me._lblEtiqueta_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_9.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_9.Location = New System.Drawing.Point(8, 60)
        Me._lblEtiqueta_9.Name = "_lblEtiqueta_9"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_9, "1069")
        Me._lblEtiqueta_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_9.Size = New System.Drawing.Size(72, 13)
        Me._lblEtiqueta_9.TabIndex = 6
        Me._lblEtiqueta_9.Text = "*Categoría:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_9, "")
        '
        'Frame1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Frame1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Frame1, False)
        Me.Frame1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.Frame1.Controls.Add(Me.cmbEstado)
        Me.Frame1.Controls.Add(Me.mskFecha)
        Me.Frame1.Controls.Add(Me._txtCampo_4)
        Me.Frame1.Controls.Add(Me.txtTotTrans)
        Me.Frame1.Controls.Add(Me.txtDebito)
        Me.Frame1.Controls.Add(Me.txtCredito)
        Me.Frame1.Controls.Add(Me.txtConsulta)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_2)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_12)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_1)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_5)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_8)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_7)
        Me.Frame1.Controls.Add(Me._lblEtiqueta_6)
        Me.Frame1.Controls.Add(Me._lblDescripcion_4)
        Me.COBISStyleProvider.SetControlStyle(Me.Frame1, "Default")
        Me.Frame1.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Frame1.ForeColor = System.Drawing.Color.Navy
        Me.Frame1.Location = New System.Drawing.Point(10, 95)
        Me.Frame1.Name = "Frame1"
        Me.COBISResourceProvider.SetResourceID(Me.Frame1, "1409" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10))
        Me.Frame1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Frame1.Size = New System.Drawing.Size(560, 110)
        Me.Frame1.TabIndex = 50
        Me.Frame1.Text = "*Información Cobro"
        Me.Frame1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Frame1, "")
        '
        'cmbEstado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbEstado, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbEstado, False)
        Me.cmbEstado.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbEstado, "Default")
        Me.cmbEstado.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbEstado.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbEstado.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmbEstado.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbEstado.Location = New System.Drawing.Point(135, 62)
        Me.cmbEstado.Name = "cmbEstado"
        Me.cmbEstado.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbEstado.Size = New System.Drawing.Size(73, 21)
        Me.cmbEstado.TabIndex = 5
        Me.cmbEstado.Tag = "6"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbEstado, "")
        '
        'mskFecha
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFecha, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFecha, False)
        Me.mskFecha.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.mskFecha, "Default")
        Me.mskFecha.Length = CType(64, Short)
        Me.mskFecha.Location = New System.Drawing.Point(135, 40)
        Me.mskFecha.Mask = "##/##/####"
        Me.mskFecha.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFecha.MaxReal = 3.402823E+38!
        Me.mskFecha.MinReal = -3.402823E+38!
        Me.mskFecha.Name = "mskFecha"
        Me.mskFecha.Size = New System.Drawing.Size(73, 20)
        Me.mskFecha.TabIndex = 4
        Me.mskFecha.Tag = "5"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFecha, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Control
        Me._txtCampo_4.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me._txtCampo_4, True)
        Me._txtCampo_4.Error = CType(0, Short)
        Me._txtCampo_4.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtCampo_4.HelpLine = Nothing
        Me._txtCampo_4.Location = New System.Drawing.Point(135, 18)
        Me._txtCampo_4.MaxLength = CType(2, Short)
        Me._txtCampo_4.MinChar = CType(0, Short)
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.Pendiente = Nothing
        Me._txtCampo_4.Range = Nothing
        Me._txtCampo_4.Size = New System.Drawing.Size(73, 20)
        Me._txtCampo_4.TabIndex = 3
        Me._txtCampo_4.TableName = Nothing
        Me._txtCampo_4.Tag = "4"
        Me._txtCampo_4.TitleCatalog = Nothing
        Me._txtCampo_4.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Alpabetic
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        'txtTotTrans
        '
        Me.txtTotTrans.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtTotTrans, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtTotTrans, False)
        Me.txtTotTrans.BackColor = System.Drawing.SystemColors.Control
        Me.txtTotTrans.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtTotTrans, "Default")
        Me.txtTotTrans.Enabled = False
        Me.COBISStyleProvider.SetEnableStyle(Me.txtTotTrans, True)
        Me.txtTotTrans.Error = CType(0, Short)
        Me.txtTotTrans.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtTotTrans.HelpLine = Nothing
        Me.txtTotTrans.Location = New System.Drawing.Point(482, 18)
        Me.txtTotTrans.MaxLength = CType(2, Short)
        Me.txtTotTrans.MinChar = CType(0, Short)
        Me.txtTotTrans.Name = "txtTotTrans"
        Me.txtTotTrans.Pendiente = Nothing
        Me.txtTotTrans.Range = Nothing
        Me.txtTotTrans.Size = New System.Drawing.Size(65, 20)
        Me.txtTotTrans.TabIndex = 6
        Me.txtTotTrans.TableName = Nothing
        Me.txtTotTrans.Tag = "7"
        Me.txtTotTrans.TitleCatalog = Nothing
        Me.txtTotTrans.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Smallint
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtTotTrans, "")
        '
        'txtDebito
        '
        Me.txtDebito.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtDebito, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtDebito, False)
        Me.txtDebito.BackColor = System.Drawing.SystemColors.Control
        Me.txtDebito.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtDebito, "Default")
        Me.txtDebito.Enabled = False
        Me.COBISStyleProvider.SetEnableStyle(Me.txtDebito, True)
        Me.txtDebito.Error = CType(0, Short)
        Me.txtDebito.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtDebito.HelpLine = Nothing
        Me.txtDebito.Location = New System.Drawing.Point(482, 40)
        Me.txtDebito.MaxLength = CType(2, Short)
        Me.txtDebito.MinChar = CType(0, Short)
        Me.txtDebito.Name = "txtDebito"
        Me.txtDebito.Pendiente = Nothing
        Me.txtDebito.Range = Nothing
        Me.txtDebito.Size = New System.Drawing.Size(65, 20)
        Me.txtDebito.TabIndex = 7
        Me.txtDebito.TableName = Nothing
        Me.txtDebito.Tag = "8"
        Me.txtDebito.TitleCatalog = Nothing
        Me.txtDebito.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Smallint
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtDebito, "")
        '
        'txtCredito
        '
        Me.txtCredito.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCredito, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCredito, False)
        Me.txtCredito.BackColor = System.Drawing.SystemColors.Control
        Me.txtCredito.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtCredito, "Default")
        Me.txtCredito.Enabled = False
        Me.COBISStyleProvider.SetEnableStyle(Me.txtCredito, True)
        Me.txtCredito.Error = CType(0, Short)
        Me.txtCredito.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCredito.HelpLine = Nothing
        Me.txtCredito.Location = New System.Drawing.Point(482, 62)
        Me.txtCredito.MaxLength = CType(2, Short)
        Me.txtCredito.MinChar = CType(0, Short)
        Me.txtCredito.Name = "txtCredito"
        Me.txtCredito.Pendiente = Nothing
        Me.txtCredito.Range = Nothing
        Me.txtCredito.Size = New System.Drawing.Size(65, 20)
        Me.txtCredito.TabIndex = 8
        Me.txtCredito.TableName = Nothing
        Me.txtCredito.Tag = "9"
        Me.txtCredito.TitleCatalog = Nothing
        Me.txtCredito.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Smallint
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCredito, "")
        '
        'txtConsulta
        '
        Me.txtConsulta.AsociatedLabelIndex = CType(0, Short)
        Me.COBISViewResizer.SetAutoRelocate(Me.txtConsulta, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtConsulta, False)
        Me.txtConsulta.BackColor = System.Drawing.SystemColors.Control
        Me.txtConsulta.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me.txtConsulta, "Default")
        Me.txtConsulta.Enabled = False
        Me.COBISStyleProvider.SetEnableStyle(Me.txtConsulta, True)
        Me.txtConsulta.Error = CType(0, Short)
        Me.txtConsulta.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtConsulta.HelpLine = Nothing
        Me.txtConsulta.Location = New System.Drawing.Point(482, 84)
        Me.txtConsulta.MaxLength = CType(2, Short)
        Me.txtConsulta.MinChar = CType(0, Short)
        Me.txtConsulta.Name = "txtConsulta"
        Me.txtConsulta.Pendiente = Nothing
        Me.txtConsulta.Range = Nothing
        Me.txtConsulta.Size = New System.Drawing.Size(65, 20)
        Me.txtConsulta.TabIndex = 9
        Me.txtConsulta.TableName = Nothing
        Me.txtConsulta.Tag = "10"
        Me.txtConsulta.TitleCatalog = Nothing
        Me.txtConsulta.Type = COBISCorp.Framework.UI.Components.ENUM_TYPE._Smallint
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtConsulta, "")
        '
        '_lblEtiqueta_2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.AutoSize = True
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(8, 62)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "1340")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(55, 13)
        Me._lblEtiqueta_2.TabIndex = 18
        Me._lblEtiqueta_2.Text = "*Estado:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_12
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_12, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_12, False)
        Me._lblEtiqueta_12.AutoSize = True
        Me._lblEtiqueta_12.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_12, "Default")
        Me._lblEtiqueta_12.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_12.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_12.Location = New System.Drawing.Point(8, 40)
        Me._lblEtiqueta_12.Name = "_lblEtiqueta_12"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_12, "1370")
        Me._lblEtiqueta_12.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_12.Size = New System.Drawing.Size(122, 13)
        Me._lblEtiqueta_12.TabIndex = 14
        Me._lblEtiqueta_12.Text = "*Fecha de Vigencia:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_12, "")
        '
        '_lblEtiqueta_1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.AutoSize = True
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(8, 18)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "1746")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(78, 13)
        Me._lblEtiqueta_1.TabIndex = 9
        Me._lblEtiqueta_1.Text = "*Tipo Cobro:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.AutoSize = True
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(358, 18)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "1788")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(119, 13)
        Me._lblEtiqueta_5.TabIndex = 12
        Me._lblEtiqueta_5.Text = "*Total Transacción:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblEtiqueta_8
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_8, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_8, False)
        Me._lblEtiqueta_8.AutoSize = True
        Me._lblEtiqueta_8.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_8, "Default")
        Me._lblEtiqueta_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_8.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_8.Location = New System.Drawing.Point(358, 84)
        Me._lblEtiqueta_8.Name = "_lblEtiqueta_8"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_8, "1048")
        Me._lblEtiqueta_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_8.Size = New System.Drawing.Size(119, 13)
        Me._lblEtiqueta_8.TabIndex = 22
        Me._lblEtiqueta_8.Text = "*Cantidad Consulta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_8, "")
        '
        '_lblEtiqueta_7
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_7, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_7, False)
        Me._lblEtiqueta_7.AutoSize = True
        Me._lblEtiqueta_7.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_7, "Default")
        Me._lblEtiqueta_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_7.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_7.Location = New System.Drawing.Point(358, 62)
        Me._lblEtiqueta_7.Name = "_lblEtiqueta_7"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_7, "1050")
        Me._lblEtiqueta_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_7.Size = New System.Drawing.Size(110, 13)
        Me._lblEtiqueta_7.TabIndex = 20
        Me._lblEtiqueta_7.Text = "*Cantidad Crédito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_7, "")
        '
        '_lblEtiqueta_6
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.AutoSize = True
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(358, 40)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "1052")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(107, 13)
        Me._lblEtiqueta_6.TabIndex = 16
        Me._lblEtiqueta_6.Text = "*Cantidad Débito:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        '_lblDescripcion_4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblDescripcion_4, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblDescripcion_4, False)
        Me._lblDescripcion_4.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_4.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_4, "Default")
        Me._lblDescripcion_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_4.Location = New System.Drawing.Point(210, 18)
        Me._lblDescripcion_4.Name = "_lblDescripcion_4"
        Me._lblDescripcion_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_4.Size = New System.Drawing.Size(140, 20)
        Me._lblDescripcion_4.TabIndex = 11
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblDescripcion_4, "")
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
        Me._cmdBoton_3.Enabled = False
        Me._cmdBoton_3.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Image = CType(resources.GetObject("_cmdBoton_3.Image"), System.Drawing.Image)
        Me._cmdBoton_3.Location = New System.Drawing.Point(526, 265)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 18
        Me._cmdBoton_3.Tag = "4112"
        Me._cmdBoton_3.Text = "&Eliminar"
        Me._cmdBoton_3.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
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
        Me._cmdBoton_0.Enabled = False
        Me._cmdBoton_0.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_0.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_0.Image = CType(resources.GetObject("_cmdBoton_0.Image"), System.Drawing.Image)
        Me._cmdBoton_0.Location = New System.Drawing.Point(526, 163)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_0, System.Drawing.Color.Silver)
        Me._cmdBoton_0.Name = "_cmdBoton_0"
        Me._cmdBoton_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_0.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_0, 1)
        Me._cmdBoton_0.TabIndex = 16
        Me._cmdBoton_0.Tag = "4110"
        Me._cmdBoton_0.Text = "&Crear"
        Me._cmdBoton_0.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_0.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_0.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_0, "")
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
        Me._cmdBoton_4.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Image = CType(resources.GetObject("_cmdBoton_4.Image"), System.Drawing.Image)
        Me._cmdBoton_4.Location = New System.Drawing.Point(526, 214)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 17
        Me._cmdBoton_4.Tag = "4111"
        Me._cmdBoton_4.Text = "&Actualizar"
        Me._cmdBoton_4.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
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
        Me._cmdBoton_1.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_1.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_1.Image = CType(resources.GetObject("_cmdBoton_1.Image"), System.Drawing.Image)
        Me._cmdBoton_1.Location = New System.Drawing.Point(526, 316)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_1, System.Drawing.Color.Silver)
        Me._cmdBoton_1.Name = "_cmdBoton_1"
        Me._cmdBoton_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_1.Size = New System.Drawing.Size(58, 48)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_1, 1)
        Me._cmdBoton_1.TabIndex = 19
        Me._cmdBoton_1.Text = "&Limpiar"
        Me._cmdBoton_1.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_1.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_1.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_1, "")
        '
        '_cmdBoton_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._cmdBoton_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._cmdBoton_5, False)
        Me._cmdBoton_5.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_5, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_5, True)
        Me._cmdBoton_5.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_5, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_5, Nothing)
        Me._cmdBoton_5.Enabled = False
        Me._cmdBoton_5.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_5.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_5.Image = CType(resources.GetObject("_cmdBoton_5.Image"), System.Drawing.Image)
        Me._cmdBoton_5.Location = New System.Drawing.Point(526, 112)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_5, System.Drawing.Color.Silver)
        Me._cmdBoton_5.Name = "_cmdBoton_5"
        Me._cmdBoton_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_5.Size = New System.Drawing.Size(58, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_5, 1)
        Me._cmdBoton_5.TabIndex = 15
        Me._cmdBoton_5.Tag = "4109"
        Me._cmdBoton_5.Text = "&Buscar"
        Me._cmdBoton_5.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_5.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_5.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_5, "")
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
        Me._cmdBoton_2.Font = New System.Drawing.Font("Arial", 6.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Image = CType(resources.GetObject("_cmdBoton_2.Image"), System.Drawing.Image)
        Me._cmdBoton_2.Location = New System.Drawing.Point(526, 370)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(58, 48)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 21
        Me._cmdBoton_2.Text = "&Salir"
        Me._cmdBoton_2.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.TSBotones.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBCrear, Me.TSBActualizar, Me.TSBEliminar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(612, 25)
        Me.TSBotones.TabIndex = 58
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "30000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "1003")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Tag = "17"
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBCrear
        '
        Me.TSBCrear.Image = CType(resources.GetObject("TSBCrear.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBCrear, "30030")
        Me.TSBCrear.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBCrear.Name = "TSBCrear"
        Me.COBISResourceProvider.SetResourceID(Me.TSBCrear, "1004")
        Me.TSBCrear.Size = New System.Drawing.Size(60, 22)
        Me.TSBCrear.Tag = "18"
        Me.TSBCrear.Text = "*&Crear"
        '
        'TSBActualizar
        '
        Me.TSBActualizar.Image = CType(resources.GetObject("TSBActualizar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBActualizar, "30005")
        Me.TSBActualizar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBActualizar.Name = "TSBActualizar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBActualizar, "1002")
        Me.TSBActualizar.Size = New System.Drawing.Size(84, 22)
        Me.TSBActualizar.Tag = "19"
        Me.TSBActualizar.Text = "*&Actualizar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "30006")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "1005")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Tag = "20"
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'TSBLimpiar
        '
        Me.TSBLimpiar.Image = CType(resources.GetObject("TSBLimpiar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBLimpiar, "30003")
        Me.TSBLimpiar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBLimpiar.Name = "TSBLimpiar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBLimpiar, "1006")
        Me.TSBLimpiar.Size = New System.Drawing.Size(72, 22)
        Me.TSBLimpiar.Tag = "21"
        Me.TSBLimpiar.Text = "*&Limpiar"
        '
        'TSBSalir
        '
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "30008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1007")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Tag = "22"
        Me.TSBSalir.Text = "*&Salir"
        '
        'PFormas
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.COBISViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.Controls.Add(Me.Frame2)
        Me.PFormas.Controls.Add(Me.Frame1)
        Me.PFormas.Controls.Add(Me.Frame3)
        Me.PFormas.Controls.Add(Me.FraTransaccion)
        Me.PFormas.Controls.Add(Me.Frame4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(580, 549)
        Me.PFormas.TabIndex = 58
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'Pforma
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Pforma, False)
        Me.COBISViewResizer.SetAutoResize(Me.Pforma, False)
        Me.Pforma.Controls.Add(Me._cmdBoton_5)
        Me.Pforma.Controls.Add(Me._cmdBoton_1)
        Me.Pforma.Controls.Add(Me._cmdBoton_4)
        Me.Pforma.Controls.Add(Me._cmdBoton_0)
        Me.Pforma.Controls.Add(Me._cmdBoton_3)
        Me.Pforma.Controls.Add(Me._cmdBoton_2)
        Me.COBISStyleProvider.SetControlStyle(Me.Pforma, "Default")
        Me.Pforma.Location = New System.Drawing.Point(0, 0)
        Me.Pforma.Name = "Pforma"
        Me.Pforma.Size = New System.Drawing.Size(614, 560)
        Me.Pforma.TabIndex = 0
        Me.Pforma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Pforma, "")
        '
        'FParComClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Location = New System.Drawing.Point(2, 28)
        Me.Name = "FParComClass"
        Me.COBISResourceProvider.SetResourceID(Me, "1623")
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(612, 603)
        Me.Text = "*Parametrización Comisiones "
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.COBISViewResizer.SetxIncrement(Me, False)
        Me.COBISViewResizer.SetyIncrement(Me, False)
        CType(Me.Frame3, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame3.ResumeLayout(False)
        CType(Me.grdParamCobCom, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.FraTransaccion, System.ComponentModel.ISupportInitialize).EndInit()
        Me.FraTransaccion.ResumeLayout(False)
        Me.FraTransaccion.PerformLayout()
        CType(Me.Frame4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame4.ResumeLayout(False)
        CType(Me.grdParamTrans, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.Frame2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame2.ResumeLayout(False)
        Me.Frame2.PerformLayout()
        CType(Me.Frame1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Frame1.ResumeLayout(False)
        Me.Frame1.PerformLayout()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        CType(Me.Pforma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.Pforma.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(2) = _txtCampo_2
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(1) = _txtCampo_1
        Me.txtCampo(4) = _txtCampo_4
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(16) = _lblEtiqueta_16
        Me.lblEtiqueta(15) = _lblEtiqueta_15
        Me.lblEtiqueta(13) = _lblEtiqueta_13
        Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(0) = _lblEtiqueta_0
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(9) = _lblEtiqueta_9
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(12) = _lblEtiqueta_12
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(8) = _lblEtiqueta_8
        Me.lblEtiqueta(7) = _lblEtiqueta_7
        Me.lblEtiqueta(6) = _lblEtiqueta_6
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(0) = _lblDescripcion_0
        Me.lblDescripcion(1) = _lblDescripcion_1
        Me.lblDescripcion(2) = _lblDescripcion_2
        Me.lblDescripcion(3) = _lblDescripcion_3
        Me.lblDescripcion(4) = _lblDescripcion_4
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(8) = _cmdBoton_8
        Me.cmdBoton(6) = _cmdBoton_6
        Me.cmdBoton(7) = _cmdBoton_7
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(0) = _cmdBoton_0
        Me.cmdBoton(4) = _cmdBoton_4
        Me.cmdBoton(1) = _cmdBoton_1
        Me.cmdBoton(5) = _cmdBoton_5
        Me.cmdBoton(2) = _cmdBoton_2
    End Sub
    Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBCrear As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBActualizar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Private WithEvents mskMonto As COBISCorp.Framework.UI.Components.CobisRealInput
#End Region 
End Class



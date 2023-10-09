Imports COBISCorp.tCOBIS.CTA.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTRAN354Class
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        InitializelblEtiqueta()
        InitializelblDescripcion()
        InitializecmdBoton()
        'InitializeLine1()
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
    Private WithEvents _txtCampo_0 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_7 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_6 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_5 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_4 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_3 As System.Windows.Forms.TextBox
    Private WithEvents _txtCampo_2 As System.Windows.Forms.TextBox
    Public WithEvents grdPropietarios As COBISCorp.Framework.UI.Components.COBISGrid
    Private WithEvents _cmdBoton_2 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_3 As System.Windows.Forms.Button
    Private WithEvents _cmdBoton_4 As System.Windows.Forms.Button
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Public WithEvents lblmalaref As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_10 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_9 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_8 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_7 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_6 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_4 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_3 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_2 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_1 As System.Windows.Forms.Label
    Private WithEvents _lblDescripcion_1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_10 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Public Line1(2) As System.Windows.Forms.Label
    Public cmdBoton(4) As System.Windows.Forms.Button
    Public lblDescripcion(10) As System.Windows.Forms.Label
    Public lblEtiqueta(11) As System.Windows.Forms.Label
    Public txtCampo(7) As System.Windows.Forms.TextBox
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper
    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTRAN354Class))
        Me._txtCampo_0 = New System.Windows.Forms.TextBox()
        Me._txtCampo_7 = New System.Windows.Forms.TextBox()
        Me._txtCampo_6 = New System.Windows.Forms.TextBox()
        Me._txtCampo_5 = New System.Windows.Forms.TextBox()
        Me._txtCampo_4 = New System.Windows.Forms.TextBox()
        Me._txtCampo_3 = New System.Windows.Forms.TextBox()
        Me._txtCampo_2 = New System.Windows.Forms.TextBox()
        Me.grdPropietarios = New COBISCorp.Framework.UI.Components.COBISGrid()
        Me._cmdBoton_2 = New System.Windows.Forms.Button()
        Me._cmdBoton_3 = New System.Windows.Forms.Button()
        Me._cmdBoton_4 = New System.Windows.Forms.Button()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.lblmalaref = New System.Windows.Forms.Label()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me._lblDescripcion_10 = New System.Windows.Forms.Label()
        Me._lblDescripcion_9 = New System.Windows.Forms.Label()
        Me._lblDescripcion_8 = New System.Windows.Forms.Label()
        Me._lblDescripcion_7 = New System.Windows.Forms.Label()
        Me._lblDescripcion_6 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_4 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_3 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_1 = New System.Windows.Forms.Label()
        Me._lblDescripcion_1 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_10 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBTransmitir = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.PFormas = New Infragistics.Win.Misc.UltraGroupBox()
        Me.UltraGroupBox2 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.CobisViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TSBotones.SuspendLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PFormas.SuspendLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.UltraGroupBox2.SuspendLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        '_txtCampo_0
        '
        Me._txtCampo_0.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_0, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_0, False)
        Me._txtCampo_0.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_0, "Default")
        Me._txtCampo_0.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_0.Enabled = False
        Me._txtCampo_0.Location = New System.Drawing.Point(128, 98)
        Me._txtCampo_0.MaxLength = 250
        Me._txtCampo_0.Name = "_txtCampo_0"
        Me._txtCampo_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_0.Size = New System.Drawing.Size(432, 20)
        Me._txtCampo_0.TabIndex = 7
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_0, "")
        '
        '_txtCampo_7
        '
        Me._txtCampo_7.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_7, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_7, False)
        Me._txtCampo_7.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_7, "Default")
        Me._txtCampo_7.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_7.Location = New System.Drawing.Point(128, 29)
        Me._txtCampo_7.MaxLength = 3
        Me._txtCampo_7.Name = "_txtCampo_7"
        Me._txtCampo_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_7.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_7.TabIndex = 4
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_7, "")
        '
        '_txtCampo_6
        '
        Me._txtCampo_6.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_6, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_6, False)
        Me._txtCampo_6.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_6, "Default")
        Me._txtCampo_6.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_6.Location = New System.Drawing.Point(150, 9)
        Me._txtCampo_6.MaxLength = 8
        Me._txtCampo_6.Name = "_txtCampo_6"
        Me._txtCampo_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_6.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_6.TabIndex = 0
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_6, "")
        '
        '_txtCampo_5
        '
        Me._txtCampo_5.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_5, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_5, False)
        Me._txtCampo_5.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_5, "Default")
        Me._txtCampo_5.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_5.Location = New System.Drawing.Point(128, 75)
        Me._txtCampo_5.MaxLength = 2
        Me._txtCampo_5.Name = "_txtCampo_5"
        Me._txtCampo_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_5.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_5.TabIndex = 6
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_5, "")
        '
        '_txtCampo_4
        '
        Me._txtCampo_4.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_4, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_4, False)
        Me._txtCampo_4.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_4, "Default")
        Me._txtCampo_4.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_4.Location = New System.Drawing.Point(128, 122)
        Me._txtCampo_4.MaxLength = 5
        Me._txtCampo_4.Name = "_txtCampo_4"
        Me._txtCampo_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_4.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_4.TabIndex = 7
        Me._txtCampo_4.Visible = False
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_4, "")
        '
        '_txtCampo_3
        '
        Me._txtCampo_3.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_3, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_3, False)
        Me._txtCampo_3.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_3, "Default")
        Me._txtCampo_3.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_3.Enabled = False
        Me._txtCampo_3.Location = New System.Drawing.Point(128, 52)
        Me._txtCampo_3.MaxLength = 2
        Me._txtCampo_3.Name = "_txtCampo_3"
        Me._txtCampo_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_3.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_3.TabIndex = 5
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_3, "")
        '
        '_txtCampo_2
        '
        Me._txtCampo_2.AcceptsReturn = True
        Me.CobisViewResizer.SetAutoRelocate(Me._txtCampo_2, False)
        Me.CobisViewResizer.SetAutoResize(Me._txtCampo_2, False)
        Me._txtCampo_2.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me._txtCampo_2, "Default")
        Me._txtCampo_2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtCampo_2.Enabled = False
        Me._txtCampo_2.Location = New System.Drawing.Point(128, 6)
        Me._txtCampo_2.MaxLength = 2
        Me._txtCampo_2.Name = "_txtCampo_2"
        Me._txtCampo_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtCampo_2.Size = New System.Drawing.Size(65, 20)
        Me._txtCampo_2.TabIndex = 3
        Me.CobisViewResizer.SetWidthRelativeTo(Me._txtCampo_2, "")
        '
        'grdPropietarios
        '
        Me.grdPropietarios._Text = ""
        Me.CobisViewResizer.SetAutoRelocate(Me.grdPropietarios, False)
        Me.CobisViewResizer.SetAutoResize(Me.grdPropietarios, False)
        Me.grdPropietarios.BackgroundColor = System.Drawing.Color.FromArgb(CType(CType(240, Byte), Integer), CType(CType(246, Byte), Integer), CType(CType(250, Byte), Integer))
        Me.grdPropietarios.Clip = ""
        Me.grdPropietarios.Col = CType(1, Short)
        Me.grdPropietarios.ColorFixedCols = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorFixedRows = System.Drawing.SystemColors.Control
        Me.grdPropietarios.ColorSelectedCells = System.Drawing.SystemColors.Highlight
        Me.grdPropietarios.Cols = 7
        Me.COBISStyleProvider.SetControlStyle(Me.grdPropietarios, "Default")
        Me.grdPropietarios.CtlText = ""
        Me.grdPropietarios.Dock = System.Windows.Forms.DockStyle.Fill
        Me.COBISStyleProvider.SetEnableStyle(Me.grdPropietarios, True)
        Me.grdPropietarios.FixedCols = CType(1, Short)
        Me.grdPropietarios.FixedRows = CType(1, Short)
        Me.grdPropietarios.ForeColor = System.Drawing.Color.Black
        Me.grdPropietarios.ForeColorFixedCols = System.Drawing.Color.Empty
        Me.grdPropietarios.ForeColorFixedRows = System.Drawing.Color.Empty
        Me.grdPropietarios.GridColor = System.Drawing.SystemColors.ControlDark
        Me.grdPropietarios.HighLight = True
        Me.grdPropietarios.Location = New System.Drawing.Point(3, 16)
        Me.grdPropietarios.Name = "grdPropietarios"
        Me.grdPropietarios.Picture = Nothing
        Me.grdPropietarios.Row = CType(1, Short)
        Me.grdPropietarios.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Me.grdPropietarios.Size = New System.Drawing.Size(566, 189)
        Me.grdPropietarios.Sort = CType(2, Short)
        Me.grdPropietarios.TabIndex = 2
        Me.grdPropietarios.TopRow = CType(1, Short)
        Me.CobisViewResizer.SetWidthRelativeTo(Me.grdPropietarios, "")
        '
        '_cmdBoton_2
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._cmdBoton_2, False)
        Me.CobisViewResizer.SetAutoResize(Me._cmdBoton_2, False)
        Me._cmdBoton_2.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_2, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_2, True)
        Me._cmdBoton_2.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_2, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_2, Nothing)
        Me._cmdBoton_2.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_2.Location = New System.Drawing.Point(616, 211)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_2, System.Drawing.Color.Silver)
        Me._cmdBoton_2.Name = "_cmdBoton_2"
        Me._cmdBoton_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_2.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_2, 1)
        Me._cmdBoton_2.TabIndex = 7
        Me._cmdBoton_2.TabStop = False
        Me._cmdBoton_2.Text = "*&Transmitir"
        Me._cmdBoton_2.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_2.UseVisualStyleBackColor = True
        Me.CobisViewResizer.SetWidthRelativeTo(Me._cmdBoton_2, "")
        '
        '_cmdBoton_3
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._cmdBoton_3, False)
        Me.CobisViewResizer.SetAutoResize(Me._cmdBoton_3, False)
        Me._cmdBoton_3.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_3, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_3, True)
        Me._cmdBoton_3.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_3, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_3, Nothing)
        Me._cmdBoton_3.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_3.Location = New System.Drawing.Point(616, 262)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_3, System.Drawing.Color.Silver)
        Me._cmdBoton_3.Name = "_cmdBoton_3"
        Me._cmdBoton_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_3.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_3, 1)
        Me._cmdBoton_3.TabIndex = 8
        Me._cmdBoton_3.TabStop = False
        Me._cmdBoton_3.Text = "*&Limpiar"
        Me._cmdBoton_3.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_3.UseVisualStyleBackColor = True
        Me.CobisViewResizer.SetWidthRelativeTo(Me._cmdBoton_3, "")
        '
        '_cmdBoton_4
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._cmdBoton_4, False)
        Me.CobisViewResizer.SetAutoResize(Me._cmdBoton_4, False)
        Me._cmdBoton_4.BackColor = System.Drawing.SystemColors.Control
        Me.COBISStyleProvider.SetControlStyle(Me._cmdBoton_4, "Default")
        Me.commandButtonHelper1.SetCorrectEventsBehavior(Me._cmdBoton_4, True)
        Me._cmdBoton_4.Cursor = System.Windows.Forms.Cursors.Default
        Me.commandButtonHelper1.SetDisabledPicture(Me._cmdBoton_4, Nothing)
        Me.commandButtonHelper1.SetDownPicture(Me._cmdBoton_4, Nothing)
        Me._cmdBoton_4.ForeColor = System.Drawing.SystemColors.ControlText
        Me._cmdBoton_4.Location = New System.Drawing.Point(616, 313)
        Me.commandButtonHelper1.SetMaskColor(Me._cmdBoton_4, System.Drawing.Color.Silver)
        Me._cmdBoton_4.Name = "_cmdBoton_4"
        Me._cmdBoton_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._cmdBoton_4.Size = New System.Drawing.Size(59, 50)
        Me.commandButtonHelper1.SetStyle(Me._cmdBoton_4, 1)
        Me._cmdBoton_4.TabIndex = 9
        Me._cmdBoton_4.TabStop = False
        Me._cmdBoton_4.Text = "*&Salir"
        Me._cmdBoton_4.TextImageRelation = System.Windows.Forms.TextImageRelation.ImageAboveText
        Me._cmdBoton_4.UseVisualStyleBackColor = True
        Me.CobisViewResizer.SetWidthRelativeTo(Me._cmdBoton_4, "")
        '
        '_lblEtiqueta_6
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_6, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_6, False)
        Me._lblEtiqueta_6.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_6, "Default")
        Me._lblEtiqueta_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_6.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(1, 99)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "5132")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(94, 20)
        Me._lblEtiqueta_6.TabIndex = 26
        Me._lblEtiqueta_6.Text = "*Observación:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'lblmalaref
        '
        Me.CobisViewResizer.SetAutoRelocate(Me.lblmalaref, False)
        Me.CobisViewResizer.SetAutoResize(Me.lblmalaref, False)
        Me.lblmalaref.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblmalaref.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblmalaref, "Default")
        Me.lblmalaref.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblmalaref.Location = New System.Drawing.Point(8, 148)
        Me.lblmalaref.Name = "lblmalaref"
        Me.lblmalaref.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblmalaref.Size = New System.Drawing.Size(563, 19)
        Me.lblmalaref.TabIndex = 24
        Me.lblmalaref.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.lblmalaref.Visible = False
        Me.CobisViewResizer.SetWidthRelativeTo(Me.lblmalaref, "")
        '
        '_lblEtiqueta_5
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(1, 30)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "500786")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(84, 20)
        Me._lblEtiqueta_5.TabIndex = 23
        Me._lblEtiqueta_5.Text = "*Categoría:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        '_lblDescripcion_10
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblDescripcion_10, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblDescripcion_10, False)
        Me._lblDescripcion_10.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_10.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_10, "Default")
        Me._lblDescripcion_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_10.Location = New System.Drawing.Point(196, 29)
        Me._lblDescripcion_10.Name = "_lblDescripcion_10"
        Me._lblDescripcion_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_10.Size = New System.Drawing.Size(363, 20)
        Me._lblDescripcion_10.TabIndex = 22
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblDescripcion_10, "")
        '
        '_lblDescripcion_9
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblDescripcion_9, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblDescripcion_9, False)
        Me._lblDescripcion_9.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_9.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_9, "Default")
        Me._lblDescripcion_9.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_9.Location = New System.Drawing.Point(196, 75)
        Me._lblDescripcion_9.Name = "_lblDescripcion_9"
        Me._lblDescripcion_9.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_9.Size = New System.Drawing.Size(363, 20)
        Me._lblDescripcion_9.TabIndex = 15
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblDescripcion_9, "")
        '
        '_lblDescripcion_8
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblDescripcion_8, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblDescripcion_8, False)
        Me._lblDescripcion_8.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_8.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_8, "Default")
        Me._lblDescripcion_8.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_8.Location = New System.Drawing.Point(194, 122)
        Me._lblDescripcion_8.Name = "_lblDescripcion_8"
        Me._lblDescripcion_8.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_8.Size = New System.Drawing.Size(376, 19)
        Me._lblDescripcion_8.TabIndex = 12
        Me._lblDescripcion_8.Visible = False
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblDescripcion_8, "")
        '
        '_lblDescripcion_7
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblDescripcion_7, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblDescripcion_7, False)
        Me._lblDescripcion_7.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_7.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_7, "Default")
        Me._lblDescripcion_7.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_7.Location = New System.Drawing.Point(196, 52)
        Me._lblDescripcion_7.Name = "_lblDescripcion_7"
        Me._lblDescripcion_7.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_7.Size = New System.Drawing.Size(363, 20)
        Me._lblDescripcion_7.TabIndex = 13
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblDescripcion_7, "")
        '
        '_lblDescripcion_6
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblDescripcion_6, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblDescripcion_6, False)
        Me._lblDescripcion_6.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_6.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_6, "Default")
        Me._lblDescripcion_6.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_6.Location = New System.Drawing.Point(196, 6)
        Me._lblDescripcion_6.Name = "_lblDescripcion_6"
        Me._lblDescripcion_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_6.Size = New System.Drawing.Size(363, 20)
        Me._lblDescripcion_6.TabIndex = 14
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblDescripcion_6, "")
        '
        '_lblEtiqueta_4
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_4, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_4, False)
        Me._lblEtiqueta_4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_4, "Default")
        Me._lblEtiqueta_4.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_4.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_4.Location = New System.Drawing.Point(1, 76)
        Me._lblEtiqueta_4.Name = "_lblEtiqueta_4"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_4, "5067")
        Me._lblEtiqueta_4.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_4.Size = New System.Drawing.Size(76, 19)
        Me._lblEtiqueta_4.TabIndex = 16
        Me._lblEtiqueta_4.Text = "*Estado:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_4, "")
        '
        '_lblEtiqueta_3
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_3, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_3, False)
        Me._lblEtiqueta_3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_3, "Default")
        Me._lblEtiqueta_3.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_3.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_3.Location = New System.Drawing.Point(1, 128)
        Me._lblEtiqueta_3.Name = "_lblEtiqueta_3"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_3, "5036")
        Me._lblEtiqueta_3.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_3.Size = New System.Drawing.Size(113, 20)
        Me._lblEtiqueta_3.TabIndex = 17
        Me._lblEtiqueta_3.Text = "*Departamento:"
        Me._lblEtiqueta_3.Visible = False
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_3, "")
        '
        '_lblEtiqueta_2
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_2, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_2, False)
        Me._lblEtiqueta_2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_2, "Default")
        Me._lblEtiqueta_2.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_2.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_2.Location = New System.Drawing.Point(1, 53)
        Me._lblEtiqueta_2.Name = "_lblEtiqueta_2"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_2, "5209")
        Me._lblEtiqueta_2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_2.Size = New System.Drawing.Size(84, 20)
        Me._lblEtiqueta_2.TabIndex = 18
        Me._lblEtiqueta_2.Text = "*Moneda:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_2, "")
        '
        '_lblEtiqueta_1
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_1, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_1, False)
        Me._lblEtiqueta_1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_1, "Default")
        Me._lblEtiqueta_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_1.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_1.Location = New System.Drawing.Point(1, 7)
        Me._lblEtiqueta_1.Name = "_lblEtiqueta_1"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_1, "5176")
        Me._lblEtiqueta_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_1.Size = New System.Drawing.Size(128, 20)
        Me._lblEtiqueta_1.TabIndex = 19
        Me._lblEtiqueta_1.Text = "*Producto bancario:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_1, "")
        '
        '_lblDescripcion_1
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblDescripcion_1, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblDescripcion_1, False)
        Me._lblDescripcion_1.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me._lblDescripcion_1.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me._lblDescripcion_1, "Default")
        Me._lblDescripcion_1.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblDescripcion_1.Location = New System.Drawing.Point(488, 8)
        Me._lblDescripcion_1.Name = "_lblDescripcion_1"
        Me._lblDescripcion_1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblDescripcion_1.Size = New System.Drawing.Size(78, 19)
        Me._lblDescripcion_1.TabIndex = 1
        Me._lblDescripcion_1.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblDescripcion_1, "")
        '
        '_lblEtiqueta_10
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_10, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_10, False)
        Me._lblEtiqueta_10.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_10, "Default")
        Me._lblEtiqueta_10.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_10.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_10.Location = New System.Drawing.Point(308, 10)
        Me._lblEtiqueta_10.Name = "_lblEtiqueta_10"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_10, "501081")
        Me._lblEtiqueta_10.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_10.Size = New System.Drawing.Size(157, 20)
        Me._lblEtiqueta_10.TabIndex = 21
        Me._lblEtiqueta_10.Text = "*Fecha de la solicitud:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_10, "")
        '
        '_lblEtiqueta_0
        '
        Me.CobisViewResizer.SetAutoRelocate(Me._lblEtiqueta_0, False)
        Me.CobisViewResizer.SetAutoResize(Me._lblEtiqueta_0, False)
        Me._lblEtiqueta_0.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_0, "Default")
        Me._lblEtiqueta_0.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_0.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 10)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "501080")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(134, 20)
        Me._lblEtiqueta_0.TabIndex = 10
        Me._lblEtiqueta_0.Text = "*Número de solicitud:"
        Me.CobisViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'TSBotones
        '
        Me.CobisViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.CobisViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBTransmitir, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(612, 25)
        Me.TSBotones.TabIndex = 30
        Me.TSBotones.Text = "ToolStrip1"
        Me.CobisViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBTransmitir
        '
        Me.TSBTransmitir.ForeColor = System.Drawing.Color.Black
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
        Me.TSBLimpiar.ForeColor = System.Drawing.Color.Black
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
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "1006")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'PFormas
        '
        Me.CobisViewResizer.SetAutoRelocate(Me.PFormas, False)
        Me.CobisViewResizer.SetAutoResize(Me.PFormas, False)
        Me.PFormas.BackColorInternal = System.Drawing.Color.White
        Me.PFormas.Controls.Add(Me.UltraGroupBox2)
        Me.PFormas.Controls.Add(Me.GroupBox1)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_0)
        Me.PFormas.Controls.Add(Me._txtCampo_6)
        Me.PFormas.Controls.Add(Me._lblEtiqueta_10)
        Me.PFormas.Controls.Add(Me._lblDescripcion_1)
        Me.PFormas.Controls.Add(Me._cmdBoton_2)
        Me.PFormas.Controls.Add(Me._cmdBoton_3)
        Me.PFormas.Controls.Add(Me._cmdBoton_4)
        Me.COBISStyleProvider.SetControlStyle(Me.PFormas, "Default")
        Me.PFormas.Location = New System.Drawing.Point(10, 36)
        Me.PFormas.Name = "PFormas"
        Me.PFormas.Size = New System.Drawing.Size(592, 376)
        Me.PFormas.TabIndex = 31
        Me.PFormas.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.CobisViewResizer.SetWidthRelativeTo(Me.PFormas, "")
        '
        'UltraGroupBox2
        '
        Me.CobisViewResizer.SetAutoRelocate(Me.UltraGroupBox2, False)
        Me.CobisViewResizer.SetAutoResize(Me.UltraGroupBox2, False)
        Me.UltraGroupBox2.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_1)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_2)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_0)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_2)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_10)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_9)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_4)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_7)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_3)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_5)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_6)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_8)
        Me.UltraGroupBox2.Controls.Add(Me._lblEtiqueta_6)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_5)
        Me.UltraGroupBox2.Controls.Add(Me._txtCampo_4)
        Me.UltraGroupBox2.Controls.Add(Me.lblmalaref)
        Me.UltraGroupBox2.Controls.Add(Me._lblDescripcion_7)
        Me.COBISStyleProvider.SetControlStyle(Me.UltraGroupBox2, "Default")
        Me.UltraGroupBox2.ForeColor = System.Drawing.Color.Navy
        Me.UltraGroupBox2.Location = New System.Drawing.Point(10, 243)
        Me.UltraGroupBox2.Name = "UltraGroupBox2"
        Me.UltraGroupBox2.Size = New System.Drawing.Size(572, 124)
        Me.UltraGroupBox2.TabIndex = 32
        Me.UltraGroupBox2.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.CobisViewResizer.SetWidthRelativeTo(Me.UltraGroupBox2, "")
        '
        'GroupBox1
        '
        Me.CobisViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.CobisViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.grdPropietarios)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 33)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "501079")
        Me.GroupBox1.Size = New System.Drawing.Size(572, 208)
        Me.GroupBox1.TabIndex = 1
        Me.GroupBox1.Text = "*Lista de Propietarios:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.CobisViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'CobisViewResizer
        '
        Me.CobisViewResizer.AutoRelocateControls = False
        Me.CobisViewResizer.AutoResizeControls = False
        Me.CobisViewResizer.ContainerForm = Me
        Me.CobisViewResizer.EnabledResize = True
        '
        'FTRAN354Class
        '
        Me.CobisViewResizer.SetAutoRelocate(Me, False)
        Me.CobisViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.PFormas)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(121, 166)
        Me.Name = "FTRAN354Class"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(612, 422)
        Me.Tag = "3100"
        Me.Text = "*Autorización de Solicitud de Apertura de Cuentas de Ahorros"
        Me.CobisViewResizer.SetWidthRelativeTo(Me, "")
        CType(Me.grdPropietarios, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PFormas, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PFormas.ResumeLayout(False)
        Me.PFormas.PerformLayout()
        CType(Me.UltraGroupBox2, System.ComponentModel.ISupportInitialize).EndInit()
        Me.UltraGroupBox2.ResumeLayout(False)
        Me.UltraGroupBox2.PerformLayout()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Sub InitializetxtCampo()
        Me.txtCampo(0) = _txtCampo_0
        Me.txtCampo(7) = _txtCampo_7
        Me.txtCampo(6) = _txtCampo_6
        Me.txtCampo(5) = _txtCampo_5
        Me.txtCampo(4) = _txtCampo_4
        Me.txtCampo(3) = _txtCampo_3
        Me.txtCampo(2) = _txtCampo_2
    End Sub
    Sub InitializelblEtiqueta()
        Me.lblEtiqueta(6) = _lblEtiqueta_6
        Me.lblEtiqueta(5) = _lblEtiqueta_5
        Me.lblEtiqueta(4) = _lblEtiqueta_4
        Me.lblEtiqueta(3) = _lblEtiqueta_3
        Me.lblEtiqueta(2) = _lblEtiqueta_2
        Me.lblEtiqueta(1) = _lblEtiqueta_1
        'Me.lblEtiqueta(11) = _lblEtiqueta_11
        Me.lblEtiqueta(10) = _lblEtiqueta_10
        Me.lblEtiqueta(0) = _lblEtiqueta_0
    End Sub
    Sub InitializelblDescripcion()
        Me.lblDescripcion(10) = _lblDescripcion_10
        Me.lblDescripcion(9) = _lblDescripcion_9
        Me.lblDescripcion(8) = _lblDescripcion_8
        Me.lblDescripcion(7) = _lblDescripcion_7
        Me.lblDescripcion(6) = _lblDescripcion_6
        Me.lblDescripcion(1) = _lblDescripcion_1
    End Sub
    Sub InitializecmdBoton()
        Me.cmdBoton(2) = _cmdBoton_2
        Me.cmdBoton(3) = _cmdBoton_3
        Me.cmdBoton(4) = _cmdBoton_4
    End Sub
    'Sub InitializeLine1()
    '    Me.Line1(2) = _Line1_2
    '    Me.Line1(1) = _Line1_1
    '    Me.Line1(0) = _Line1_0
    'End Sub
    'Friend WithEvents Pforma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBTransmitir As System.Windows.Forms.ToolStripButton
    Friend WithEvents PFormas As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents CobisViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents UltraGroupBox2 As Infragistics.Win.Misc.UltraGroupBox
#End Region
End Class



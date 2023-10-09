Imports COBISCorp.tCOBIS.CON.MXN.SharedLibrary
<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FSolRepRegClass
#Region "Windows Form Designer generated code "
    Public Sub New()
        MyBase.New()
        isInitializingComponent = True
        InitializeComponent()
        isInitializingComponent = False
        InitializetxtCampo()
        Initializelbldescripcion()
        InitializelblEtiqueta()
    End Sub

    Private Sub ReleaseResources(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Closed
        Dispose(True)
    End Sub

    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not (components Is Nothing) Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub

    Private components As System.ComponentModel.IContainer
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Public Line1(2) As System.Windows.Forms.Label
    Private commandButtonHelper1 As Artinsoft.VB6.Gui.CommandButtonHelper

    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FSolRepRegClass))
        Dim CheckBoxCellType1 As FarPoint.Win.Spread.CellType.CheckBoxCellType = New FarPoint.Win.Spread.CellType.CheckBoxCellType()
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBBuscar = New System.Windows.Forms.ToolStripButton()
        Me.TSBIngresar = New System.Windows.Forms.ToolStripButton()
        Me.TSBLimpiar = New System.Windows.Forms.ToolStripButton()
        Me.TSBSalir = New System.Windows.Forms.ToolStripButton()
        Me.grpListado = New System.Windows.Forms.GroupBox()
        Me.grdRegistros = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdRegistros_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me.ugbContenedor = New Infragistics.Win.Misc.UltraGroupBox()
        Me.chkMarcarTodos = New System.Windows.Forms.CheckBox()
        Me._lblAnio = New System.Windows.Forms.Label()
        Me._lblMes = New System.Windows.Forms.Label()
        Me.cmbMes = New System.Windows.Forms.ComboBox()
        Me._txtAnio = New System.Windows.Forms.TextBox()
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.commandButtonHelper1 = New Artinsoft.VB6.Gui.CommandButtonHelper(Me.components)
        Me.TSBotones.SuspendLayout()
        Me.grpListado.SuspendLayout()
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdRegistros_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ugbContenedor, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.ugbContenedor.SuspendLayout()
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
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.TSBotones.BackColor = System.Drawing.Color.White
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBBuscar, Me.TSBIngresar, Me.TSBLimpiar, Me.TSBSalir})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(559, 25)
        Me.TSBotones.TabIndex = 0
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBBuscar
        '
        Me.TSBBuscar.ForeColor = System.Drawing.Color.Black
        Me.TSBBuscar.Image = CType(resources.GetObject("TSBBuscar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBBuscar.Name = "TSBBuscar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBBuscar, "2000")
        Me.TSBBuscar.Size = New System.Drawing.Size(67, 22)
        Me.TSBBuscar.Tag = "6623"
        Me.TSBBuscar.Text = "*&Buscar"
        '
        'TSBIngresar
        '
        Me.TSBIngresar.ForeColor = System.Drawing.Color.Black
        Me.TSBIngresar.Image = CType(resources.GetObject("TSBIngresar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBIngresar, "2004")
        Me.TSBIngresar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBIngresar.Name = "TSBIngresar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBIngresar, "2004")
        Me.TSBIngresar.Size = New System.Drawing.Size(74, 22)
        Me.TSBIngresar.Tag = "6625"
        Me.TSBIngresar.Text = "*&Ingresar"
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
        Me.TSBSalir.BackColor = System.Drawing.Color.White
        Me.TSBSalir.ForeColor = System.Drawing.Color.Black
        Me.TSBSalir.Image = CType(resources.GetObject("TSBSalir.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBSalir, "2008")
        Me.TSBSalir.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBSalir.Name = "TSBSalir"
        Me.COBISResourceProvider.SetResourceID(Me.TSBSalir, "2008")
        Me.TSBSalir.Size = New System.Drawing.Size(54, 22)
        Me.TSBSalir.Text = "*&Salir"
        '
        'grpListado
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.grpListado, False)
        Me.COBISViewResizer.SetAutoResize(Me.grpListado, False)
        Me.grpListado.BackColor = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.grpListado.Controls.Add(Me.grdRegistros)
        Me.COBISStyleProvider.SetControlStyle(Me.grpListado, "Default")
        Me.grpListado.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.grpListado, "3062")
        Me.grpListado.Location = New System.Drawing.Point(6, 60)
        Me.grpListado.Name = "grpListado"
        Me.COBISResourceProvider.SetResourceID(Me.grpListado, "3062")
        Me.grpListado.Size = New System.Drawing.Size(541, 335)
        Me.grpListado.TabIndex = 5
        Me.grpListado.TabStop = False
        Me.grpListado.Text = "*Listado Reportes Regulatorios"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grpListado, "")
        '
        'grdRegistros
        '
        Me.grdRegistros.AccessibleDescription = ""
        Me.COBISViewResizer.SetAutoRelocate(Me.grdRegistros, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdRegistros, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdRegistros, "COBIS")
        Me.grdRegistros.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdRegistros.Font = New System.Drawing.Font("Tahoma", 8.25!)
        Me.grdRegistros.Location = New System.Drawing.Point(6, 19)
        Me.grdRegistros.Name = "grdRegistros"
        Me.grdRegistros.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdRegistros_Sheet1})
        Me.grdRegistros.Size = New System.Drawing.Size(529, 310)
        Me.grdRegistros.StartingColNumber = 1
        Me.grdRegistros.StartingRowNumber = 1
        Me.grdRegistros.TabIndex = 0
        Me.grdRegistros.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeVGABase
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdRegistros, "")
        '
        'grdRegistros_Sheet1
        '
        Me.grdRegistros_Sheet1.Reset()
        Me.grdRegistros_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.grdRegistros_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.grdRegistros_Sheet1.ColumnCount = 4
        Me.grdRegistros_Sheet1.RowCount = 0
        Me.grdRegistros_Sheet1.ActiveRowIndex = -1
        Me.grdRegistros_Sheet1.Columns.Get(2).CellType = CheckBoxCellType1
        Me.grdRegistros_Sheet1.Columns.Get(2).HorizontalAlignment = FarPoint.Win.Spread.CellHorizontalAlignment.Center
        Me.grdRegistros_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        Me.grdRegistros.SetActiveViewport(0, -1, 0)
        '
        'ugbContenedor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.ugbContenedor, False)
        Me.COBISViewResizer.SetAutoResize(Me.ugbContenedor, False)
        Me.ugbContenedor.BackColorInternal = System.Drawing.Color.White
        Me.ugbContenedor.Controls.Add(Me.chkMarcarTodos)
        Me.ugbContenedor.Controls.Add(Me._lblAnio)
        Me.ugbContenedor.Controls.Add(Me._lblMes)
        Me.ugbContenedor.Controls.Add(Me.cmbMes)
        Me.ugbContenedor.Controls.Add(Me.grpListado)
        Me.ugbContenedor.Controls.Add(Me._txtAnio)
        Me.COBISStyleProvider.SetControlStyle(Me.ugbContenedor, "Default")
        Me.ugbContenedor.Location = New System.Drawing.Point(3, 28)
        Me.ugbContenedor.Name = "ugbContenedor"
        Me.ugbContenedor.Size = New System.Drawing.Size(553, 404)
        Me.ugbContenedor.TabIndex = 1
        Me.ugbContenedor.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.ugbContenedor, "")
        '
        'chkMarcarTodos
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.chkMarcarTodos, False)
        Me.COBISViewResizer.SetAutoResize(Me.chkMarcarTodos, False)
        Me.chkMarcarTodos.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.chkMarcarTodos, "Default")
        Me.chkMarcarTodos.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkMarcarTodos.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me.chkMarcarTodos, "3140")
        Me.chkMarcarTodos.Location = New System.Drawing.Point(401, 35)
        Me.chkMarcarTodos.Name = "chkMarcarTodos"
        Me.COBISResourceProvider.SetResourceID(Me.chkMarcarTodos, "3140")
        Me.chkMarcarTodos.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkMarcarTodos.Size = New System.Drawing.Size(146, 20)
        Me.chkMarcarTodos.TabIndex = 4
        Me.chkMarcarTodos.Text = "*Marcar Todos"
        Me.chkMarcarTodos.UseVisualStyleBackColor = True
        Me.COBISViewResizer.SetWidthRelativeTo(Me.chkMarcarTodos, "")
        '
        '_lblAnio
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblAnio, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblAnio, False)
        Me._lblAnio.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblAnio, "Default")
        Me._lblAnio.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblAnio.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblAnio, "3061")
        Me._lblAnio.Location = New System.Drawing.Point(6, 35)
        Me._lblAnio.Name = "_lblAnio"
        Me.COBISResourceProvider.SetResourceID(Me._lblAnio, "3061")
        Me._lblAnio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblAnio.Size = New System.Drawing.Size(74, 19)
        Me._lblAnio.TabIndex = 2
        Me._lblAnio.Text = "* Año:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblAnio, "")
        '
        '_lblMes
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblMes, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblMes, False)
        Me._lblMes.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblMes, "Default")
        Me._lblMes.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblMes.ForeColor = System.Drawing.Color.Navy
        Me.COBISResourceProvider.SetImageID(Me._lblMes, "3060")
        Me._lblMes.Location = New System.Drawing.Point(6, 11)
        Me._lblMes.Name = "_lblMes"
        Me.COBISResourceProvider.SetResourceID(Me._lblMes, "3060")
        Me._lblMes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblMes.Size = New System.Drawing.Size(74, 19)
        Me._lblMes.TabIndex = 0
        Me._lblMes.Text = "* Mes:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblMes, "")
        '
        'cmbMes
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.cmbMes, False)
        Me.COBISViewResizer.SetAutoResize(Me.cmbMes, False)
        Me.cmbMes.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.cmbMes, "Default")
        Me.cmbMes.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmbMes.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cmbMes.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cmbMes.Location = New System.Drawing.Point(86, 11)
        Me.cmbMes.Name = "cmbMes"
        Me.cmbMes.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmbMes.Size = New System.Drawing.Size(160, 21)
        Me.cmbMes.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.cmbMes, "")
        '
        '_txtAnio
        '
        Me._txtAnio.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me._txtAnio, False)
        Me.COBISViewResizer.SetAutoResize(Me._txtAnio, False)
        Me._txtAnio.BackColor = System.Drawing.SystemColors.Window
        Me._txtAnio.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.COBISStyleProvider.SetControlStyle(Me._txtAnio, "Default")
        Me._txtAnio.Cursor = System.Windows.Forms.Cursors.IBeam
        Me._txtAnio.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me._txtAnio.ForeColor = System.Drawing.Color.Black
        Me._txtAnio.Location = New System.Drawing.Point(86, 35)
        Me._txtAnio.MaxLength = 4
        Me._txtAnio.Name = "_txtAnio"
        Me._txtAnio.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._txtAnio.Size = New System.Drawing.Size(160, 20)
        Me._txtAnio.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me._txtAnio, "")
        Me.COBISViewResizer.SetxIncrement(Me._txtAnio, False)
        '
        'FSolRepRegClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScroll = True
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.Controls.Add(Me.ugbContenedor)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.Location = New System.Drawing.Point(24, 72)
        Me.Name = "FSolRepRegClass"
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.Size = New System.Drawing.Size(559, 436)
        Me.Text = "Códigos de Valores Contables"
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        Me.grpListado.ResumeLayout(False)
        CType(Me.grdRegistros, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdRegistros_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ugbContenedor, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ugbContenedor.ResumeLayout(False)
        Me.ugbContenedor.PerformLayout()
        CType(Me.commandButtonHelper1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub

    Sub InitializetxtCampo()
    End Sub

    Sub Initializelbldescripcion()
    End Sub

    Sub InitializelblEtiqueta()
    End Sub

    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBIngresar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBLimpiar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBBuscar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBSalir As System.Windows.Forms.ToolStripButton
    Friend WithEvents grpListado As System.Windows.Forms.GroupBox
    Friend WithEvents ugbContenedor As Infragistics.Win.Misc.UltraGroupBox
    Public WithEvents grdRegistros As COBISCorp.Framework.UI.Components.COBISSpread
    Friend WithEvents grdRegistros_Sheet1 As FarPoint.Win.Spread.SheetView
    Private WithEvents _txtAnio As System.Windows.Forms.TextBox
    Public WithEvents cmbMes As System.Windows.Forms.ComboBox
    Private WithEvents _lblMes As System.Windows.Forms.Label
    Private WithEvents _lblAnio As System.Windows.Forms.Label
    Protected WithEvents chkMarcarTodos As System.Windows.Forms.CheckBox
#End Region
End Class



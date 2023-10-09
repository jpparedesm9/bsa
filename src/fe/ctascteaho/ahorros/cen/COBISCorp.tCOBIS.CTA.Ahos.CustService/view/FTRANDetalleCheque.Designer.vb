<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FTRANDetalleChequeClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    'UserControl overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(FTRANDetalleChequeClass))
        Me.COBISViewResizer = New COBISCorp.eCOBIS.Commons.COBISViewResizer(Me.components)
        Me.TSBotones = New System.Windows.Forms.ToolStrip()
        Me.TSBAceptar = New System.Windows.Forms.ToolStripButton()
        Me.TSBAgregar = New System.Windows.Forms.ToolStripButton()
        Me.TSBEliminar = New System.Windows.Forms.ToolStripButton()
        Me.PForma = New Infragistics.Win.Misc.UltraGroupBox()
        Me.grdDetalle = New COBISCorp.Framework.UI.Components.COBISSpread()
        Me.grdDetalle_Sheet1 = New FarPoint.Win.Spread.SheetView()
        Me.GroupBox1 = New Infragistics.Win.Misc.UltraGroupBox()
        Me.txtCoMoneda = New System.Windows.Forms.TextBox()
        Me.lblNoMoneda = New System.Windows.Forms.Label()
        Me.mskCuenta = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.lblNoCuenta = New System.Windows.Forms.Label()
        Me.txtNumCuenta = New System.Windows.Forms.TextBox()
        Me.txtBanco = New System.Windows.Forms.TextBox()
        Me.txtCoBanco = New System.Windows.Forms.TextBox()
        Me.txtCoTipo = New System.Windows.Forms.TextBox()
        Me.txtNumCheque = New System.Windows.Forms.TextBox()
        Me._lblEtiqueta_5 = New System.Windows.Forms.Label()
        Me.mskFechaEmi = New COBISCorp.Framework.UI.Components.COBISMaskedTextBox()
        Me.lblNoBanco = New System.Windows.Forms.Label()
        Me.lblNoTipo = New System.Windows.Forms.Label()
        Me.Label4 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me._lblEtiqueta_0 = New System.Windows.Forms.Label()
        Me.mskCotizacion = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me._lblEtiqueta_6 = New System.Windows.Forms.Label()
        Me.lblCotizacion = New System.Windows.Forms.Label()
        Me.mskValorConvertido = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.mskValor = New COBISCorp.Framework.UI.Components.COBISMaskedInBox()
        Me.lblvalorCon = New System.Windows.Forms.Label()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.COBISResourceProvider = New COBISCorp.Framework.UI.Components.COBISResourceProvider(Me.components)
        Me.COBISStyleProvider = New COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider(Me.components)
        Me.TSBotones.SuspendLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.PForma.SuspendLayout()
        CType(Me.grdDetalle, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grdDetalle_Sheet1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.GroupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'COBISViewResizer
        '
        Me.COBISViewResizer.AutoRelocateControls = False
        Me.COBISViewResizer.AutoResizeControls = False
        Me.COBISViewResizer.EnabledResize = True
        '
        'TSBotones
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.TSBotones, False)
        Me.COBISViewResizer.SetAutoResize(Me.TSBotones, False)
        Me.COBISStyleProvider.SetControlStyle(Me.TSBotones, "Default")
        Me.TSBotones.Items.AddRange(New System.Windows.Forms.ToolStripItem() {Me.TSBAceptar, Me.TSBAgregar, Me.TSBEliminar})
        Me.TSBotones.Location = New System.Drawing.Point(0, 0)
        Me.TSBotones.Name = "TSBotones"
        Me.TSBotones.Size = New System.Drawing.Size(625, 25)
        Me.TSBotones.TabIndex = 0
        Me.TSBotones.Text = "ToolStrip1"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.TSBotones, "")
        '
        'TSBAceptar
        '
        Me.TSBAceptar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBAceptar.Image = CType(resources.GetObject("TSBAceptar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAceptar, "2007")
        Me.TSBAceptar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAceptar.Name = "TSBAceptar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAceptar, "2011")
        Me.TSBAceptar.Size = New System.Drawing.Size(73, 22)
        Me.TSBAceptar.Text = "*&Aceptar"
        '
        'TSBAgregar
        '
        Me.TSBAgregar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBAgregar.Image = CType(resources.GetObject("TSBAgregar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBAgregar, "2003")
        Me.TSBAgregar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBAgregar.Name = "TSBAgregar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBAgregar, "500124")
        Me.TSBAgregar.Size = New System.Drawing.Size(74, 22)
        Me.TSBAgregar.Text = "*&Agregar"
        '
        'TSBEliminar
        '
        Me.TSBEliminar.ForeColor = System.Drawing.SystemColors.ControlText
        Me.TSBEliminar.Image = CType(resources.GetObject("TSBEliminar.Image"), System.Drawing.Image)
        Me.COBISResourceProvider.SetImageID(Me.TSBEliminar, "2008")
        Me.TSBEliminar.ImageTransparentColor = System.Drawing.Color.Magenta
        Me.TSBEliminar.Name = "TSBEliminar"
        Me.COBISResourceProvider.SetResourceID(Me.TSBEliminar, "2050")
        Me.TSBEliminar.Size = New System.Drawing.Size(75, 22)
        Me.TSBEliminar.Text = "*&Eliminar"
        '
        'PForma
        '
        Me.PForma.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.PForma, False)
        Me.COBISViewResizer.SetAutoResize(Me.PForma, False)
        Me.PForma.BackColorInternal = System.Drawing.Color.White
        Me.PForma.Controls.Add(Me.grdDetalle)
        Me.PForma.Controls.Add(Me.GroupBox1)
        Me.COBISStyleProvider.SetControlStyle(Me.PForma, "Default")
        Me.PForma.Location = New System.Drawing.Point(8, 33)
        Me.PForma.Name = "PForma"
        Me.PForma.Size = New System.Drawing.Size(608, 357)
        Me.PForma.TabIndex = 1
        Me.PForma.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.PForma, "")
        '
        'grdDetalle
        '
        Me.grdDetalle.AccessibleDescription = ""
        Me.grdDetalle.Anchor = CType((((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Bottom) _
            Or System.Windows.Forms.AnchorStyles.Left) _
            Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.COBISViewResizer.SetAutoRelocate(Me.grdDetalle, False)
        Me.COBISViewResizer.SetAutoResize(Me.grdDetalle, False)
        Me.COBISStyleProvider.SetControlStyle(Me.grdDetalle, "Default")
        Me.grdDetalle.CursorStyle = COBISCorp.Framework.UI.Components.CursorStyleConstants.CursorStyleUserDefined
        Me.grdDetalle.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.grdDetalle.Location = New System.Drawing.Point(10, 185)
        Me.grdDetalle.Name = "grdDetalle"
        Me.grdDetalle.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.grdDetalle.Sheets.AddRange(New FarPoint.Win.Spread.SheetView() {Me.grdDetalle_Sheet1})
        Me.grdDetalle.Size = New System.Drawing.Size(592, 166)
        Me.grdDetalle.StartingColNumber = 1
        Me.grdDetalle.StartingRowNumber = 1
        Me.grdDetalle.TabIndex = 7
        Me.grdDetalle.UnitType = COBISCorp.Framework.UI.Components.UnitTypeConstants.UnitTypeTwips
        Me.COBISViewResizer.SetWidthRelativeTo(Me.grdDetalle, "")
        '
        'grdDetalle_Sheet1
        '
        Me.grdDetalle_Sheet1.Reset()
        Me.grdDetalle_Sheet1.SheetName = "Sheet1"
        'Formulas and custom names must be loaded with R1C1 reference style
        Me.grdDetalle_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.R1C1
        Me.grdDetalle_Sheet1.ColumnCount = 0
        Me.grdDetalle_Sheet1.RowCount = 0
        Me.grdDetalle_Sheet1.ActiveColumnIndex = -1
        Me.grdDetalle_Sheet1.ActiveRowIndex = -1
        Me.grdDetalle_Sheet1.OperationMode = FarPoint.Win.Spread.OperationMode.[ReadOnly]
        Me.grdDetalle_Sheet1.Protect = False
        Me.grdDetalle_Sheet1.RowHeader.Columns.Default.Resizable = False
        Me.grdDetalle_Sheet1.ReferenceStyle = FarPoint.Win.Spread.Model.ReferenceStyle.A1
        Me.grdDetalle.SetActiveViewport(0, -1, -1)
        '
        'GroupBox1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.GroupBox1, False)
        Me.COBISViewResizer.SetAutoResize(Me.GroupBox1, False)
        Me.GroupBox1.BackColorInternal = System.Drawing.Color.FromArgb(CType(CType(205, Byte), Integer), CType(CType(222, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.GroupBox1.Controls.Add(Me.txtCoMoneda)
        Me.GroupBox1.Controls.Add(Me.lblNoMoneda)
        Me.GroupBox1.Controls.Add(Me.mskCuenta)
        Me.GroupBox1.Controls.Add(Me.lblNoCuenta)
        Me.GroupBox1.Controls.Add(Me.txtNumCuenta)
        Me.GroupBox1.Controls.Add(Me.txtBanco)
        Me.GroupBox1.Controls.Add(Me.txtCoBanco)
        Me.GroupBox1.Controls.Add(Me.txtCoTipo)
        Me.GroupBox1.Controls.Add(Me.txtNumCheque)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_5)
        Me.GroupBox1.Controls.Add(Me.mskFechaEmi)
        Me.GroupBox1.Controls.Add(Me.lblNoBanco)
        Me.GroupBox1.Controls.Add(Me.lblNoTipo)
        Me.GroupBox1.Controls.Add(Me.Label4)
        Me.GroupBox1.Controls.Add(Me.Label2)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_0)
        Me.GroupBox1.Controls.Add(Me.mskCotizacion)
        Me.GroupBox1.Controls.Add(Me._lblEtiqueta_6)
        Me.GroupBox1.Controls.Add(Me.lblCotizacion)
        Me.GroupBox1.Controls.Add(Me.mskValorConvertido)
        Me.GroupBox1.Controls.Add(Me.mskValor)
        Me.GroupBox1.Controls.Add(Me.lblvalorCon)
        Me.GroupBox1.Controls.Add(Me.Label1)
        Me.GroupBox1.Controls.Add(Me.Label3)
        Me.COBISStyleProvider.SetControlStyle(Me.GroupBox1, "Default")
        Me.GroupBox1.ForeColor = System.Drawing.Color.Navy
        Me.GroupBox1.Location = New System.Drawing.Point(10, 10)
        Me.GroupBox1.Name = "GroupBox1"
        Me.COBISResourceProvider.SetResourceID(Me.GroupBox1, "5264")
        Me.GroupBox1.Size = New System.Drawing.Size(592, 169)
        Me.GroupBox1.TabIndex = 30
        Me.GroupBox1.Text = "*Información del Cheque:"
        Me.GroupBox1.ViewStyle = Infragistics.Win.Misc.GroupBoxViewStyle.Office2007
        Me.COBISViewResizer.SetWidthRelativeTo(Me.GroupBox1, "")
        '
        'txtCoMoneda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCoMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCoMoneda, False)
        Me.txtCoMoneda.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCoMoneda, "Default")
        Me.txtCoMoneda.Enabled = False
        Me.txtCoMoneda.Location = New System.Drawing.Point(121, 107)
        Me.txtCoMoneda.MaxLength = 5
        Me.txtCoMoneda.Name = "txtCoMoneda"
        Me.txtCoMoneda.Size = New System.Drawing.Size(45, 20)
        Me.txtCoMoneda.TabIndex = 38
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCoMoneda, "")
        '
        'lblNoMoneda
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNoMoneda, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNoMoneda, False)
        Me.lblNoMoneda.BackColor = System.Drawing.Color.White
        Me.lblNoMoneda.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNoMoneda, "Default")
        Me.lblNoMoneda.Location = New System.Drawing.Point(169, 107)
        Me.lblNoMoneda.Name = "lblNoMoneda"
        Me.lblNoMoneda.Size = New System.Drawing.Size(401, 20)
        Me.lblNoMoneda.TabIndex = 37
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNoMoneda, "")
        '
        'mskCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskCuenta, "Default")
        Me.mskCuenta.Length = CType(5, Short)
        Me.mskCuenta.Location = New System.Drawing.Point(121, 63)
        Me.mskCuenta.MaxReal = 3.402823E+38!
        Me.mskCuenta.MinReal = -3.402823E+38!
        Me.mskCuenta.Name = "mskCuenta"
        Me.mskCuenta.Size = New System.Drawing.Size(147, 20)
        Me.mskCuenta.TabIndex = 36
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCuenta, "")
        '
        'lblNoCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNoCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNoCuenta, False)
        Me.lblNoCuenta.BackColor = System.Drawing.Color.White
        Me.lblNoCuenta.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNoCuenta, "Default")
        Me.lblNoCuenta.Location = New System.Drawing.Point(270, 63)
        Me.lblNoCuenta.Name = "lblNoCuenta"
        Me.lblNoCuenta.Size = New System.Drawing.Size(300, 20)
        Me.lblNoCuenta.TabIndex = 34
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNoCuenta, "")
        '
        'txtNumCuenta
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNumCuenta, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNumCuenta, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtNumCuenta, "Default")
        Me.txtNumCuenta.Location = New System.Drawing.Point(576, 62)
        Me.txtNumCuenta.MaxLength = 14
        Me.txtNumCuenta.Name = "txtNumCuenta"
        Me.txtNumCuenta.Size = New System.Drawing.Size(172, 20)
        Me.txtNumCuenta.TabIndex = 3
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNumCuenta, "")
        '
        'txtBanco
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.txtBanco, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtBanco, False)
        Me.COBISStyleProvider.SetControlStyle(Me.txtBanco, "Default")
        Me.txtBanco.Location = New System.Drawing.Point(576, 40)
        Me.txtBanco.MaxLength = 50
        Me.txtBanco.Name = "txtBanco"
        Me.txtBanco.Size = New System.Drawing.Size(172, 20)
        Me.txtBanco.TabIndex = 33
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtBanco, "")
        '
        'txtCoBanco
        '
        Me.txtCoBanco.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCoBanco, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCoBanco, False)
        Me.txtCoBanco.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCoBanco, "Default")
        Me.txtCoBanco.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCoBanco.Location = New System.Drawing.Point(121, 41)
        Me.txtCoBanco.MaxLength = 2
        Me.txtCoBanco.Name = "txtCoBanco"
        Me.txtCoBanco.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCoBanco.Size = New System.Drawing.Size(45, 20)
        Me.txtCoBanco.TabIndex = 0
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCoBanco, "")
        '
        'txtCoTipo
        '
        Me.txtCoTipo.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtCoTipo, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtCoTipo, False)
        Me.txtCoTipo.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtCoTipo, "Default")
        Me.txtCoTipo.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCoTipo.Location = New System.Drawing.Point(121, 19)
        Me.txtCoTipo.MaxLength = 2
        Me.txtCoTipo.Name = "txtCoTipo"
        Me.txtCoTipo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCoTipo.Size = New System.Drawing.Size(45, 20)
        Me.txtCoTipo.TabIndex = 1
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtCoTipo, "")
        '
        'txtNumCheque
        '
        Me.txtNumCheque.AcceptsReturn = True
        Me.COBISViewResizer.SetAutoRelocate(Me.txtNumCheque, False)
        Me.COBISViewResizer.SetAutoResize(Me.txtNumCheque, False)
        Me.txtNumCheque.BackColor = System.Drawing.SystemColors.Window
        Me.COBISStyleProvider.SetControlStyle(Me.txtNumCheque, "Default")
        Me.txtNumCheque.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtNumCheque.Location = New System.Drawing.Point(121, 85)
        Me.txtNumCheque.MaxLength = 7
        Me.txtNumCheque.Name = "txtNumCheque"
        Me.txtNumCheque.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtNumCheque.Size = New System.Drawing.Size(147, 20)
        Me.txtNumCheque.TabIndex = 4
        Me.COBISViewResizer.SetWidthRelativeTo(Me.txtNumCheque, "")
        '
        '_lblEtiqueta_5
        '
        Me.COBISViewResizer.SetAutoRelocate(Me._lblEtiqueta_5, False)
        Me.COBISViewResizer.SetAutoResize(Me._lblEtiqueta_5, False)
        Me._lblEtiqueta_5.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me._lblEtiqueta_5, "Default")
        Me._lblEtiqueta_5.Cursor = System.Windows.Forms.Cursors.Default
        Me._lblEtiqueta_5.ForeColor = System.Drawing.Color.Navy
        Me._lblEtiqueta_5.Location = New System.Drawing.Point(287, 130)
        Me._lblEtiqueta_5.Name = "_lblEtiqueta_5"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_5, "502435")
        Me._lblEtiqueta_5.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_5.Size = New System.Drawing.Size(101, 20)
        Me._lblEtiqueta_5.TabIndex = 28
        Me._lblEtiqueta_5.Text = "*Fecha de emisión:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_5, "")
        '
        'mskFechaEmi
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskFechaEmi, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskFechaEmi, False)
        Me.COBISStyleProvider.SetControlStyle(Me.mskFechaEmi, "Default")
        Me.mskFechaEmi.Length = CType(64, Short)
        Me.mskFechaEmi.Location = New System.Drawing.Point(390, 130)
        Me.mskFechaEmi.Mask = "##/##/####"
        Me.mskFechaEmi.MaskType = COBISCorp.Framework.UI.Components.ENUM_MASK.[Date]
        Me.mskFechaEmi.MaxReal = 3.402823E+38!
        Me.mskFechaEmi.MinReal = -3.402823E+38!
        Me.mskFechaEmi.Name = "mskFechaEmi"
        Me.mskFechaEmi.Size = New System.Drawing.Size(91, 20)
        Me.mskFechaEmi.TabIndex = 6
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskFechaEmi, "")
        '
        'lblNoBanco
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNoBanco, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNoBanco, False)
        Me.lblNoBanco.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblNoBanco.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNoBanco, "Default")
        Me.lblNoBanco.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNoBanco.Location = New System.Drawing.Point(169, 41)
        Me.lblNoBanco.Name = "lblNoBanco"
        Me.lblNoBanco.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNoBanco.Size = New System.Drawing.Size(401, 19)
        Me.lblNoBanco.TabIndex = 24
        Me.lblNoBanco.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNoBanco, "")
        '
        'lblNoTipo
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblNoTipo, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblNoTipo, False)
        Me.lblNoTipo.BackColor = System.Drawing.Color.FromArgb(CType(CType(233, Byte), Integer), CType(CType(236, Byte), Integer), CType(CType(240, Byte), Integer))
        Me.lblNoTipo.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.COBISStyleProvider.SetControlStyle(Me.lblNoTipo, "Default")
        Me.lblNoTipo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblNoTipo.Location = New System.Drawing.Point(169, 19)
        Me.lblNoTipo.Name = "lblNoTipo"
        Me.lblNoTipo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblNoTipo.Size = New System.Drawing.Size(401, 19)
        Me.lblNoTipo.TabIndex = 22
        Me.lblNoTipo.UseMnemonic = False
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblNoTipo, "")
        '
        'Label4
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label4, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label4, False)
        Me.Label4.AutoSize = True
        Me.Label4.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label4, "Default")
        Me.Label4.ForeColor = System.Drawing.Color.Navy
        Me.Label4.Location = New System.Drawing.Point(10, 20)
        Me.Label4.Name = "Label4"
        Me.COBISResourceProvider.SetResourceID(Me.Label4, "500305")
        Me.Label4.Size = New System.Drawing.Size(92, 13)
        Me.Label4.TabIndex = 18
        Me.Label4.Text = "*Tipo de cheque :"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label4, "")
        '
        'Label2
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label2, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label2, False)
        Me.Label2.AutoSize = True
        Me.Label2.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label2, "Default")
        Me.Label2.ForeColor = System.Drawing.Color.Navy
        Me.Label2.Location = New System.Drawing.Point(10, 41)
        Me.Label2.Name = "Label2"
        Me.COBISResourceProvider.SetResourceID(Me.Label2, "5265")
        Me.Label2.Size = New System.Drawing.Size(78, 13)
        Me.Label2.TabIndex = 17
        Me.Label2.Text = "*Banco emisor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label2, "")
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
        Me._lblEtiqueta_0.Location = New System.Drawing.Point(10, 63)
        Me._lblEtiqueta_0.Name = "_lblEtiqueta_0"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_0, "500627")
        Me._lblEtiqueta_0.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_0.Size = New System.Drawing.Size(102, 13)
        Me._lblEtiqueta_0.TabIndex = 7
        Me._lblEtiqueta_0.Text = "*Número de cuenta:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_0, "")
        '
        'mskCotizacion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskCotizacion, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskCotizacion, False)
        Me.mskCotizacion.BackColor = System.Drawing.SystemColors.Window
        Me.mskCotizacion.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskCotizacion.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskCotizacion, "Default")
        Me.mskCotizacion.Cuantas = 0
        Me.mskCotizacion.DateString = "_.$"
        Me.mskCotizacion.DateSybase = Nothing
        Me.mskCotizacion.Decimals = CType(2, Short)
        Me.mskCotizacion.Enabled = False
        Me.mskCotizacion.Errores = CType(0, Short)
        Me.mskCotizacion.Fin = 0
        Me.mskCotizacion.FormattedText = Nothing
        Me.mskCotizacion.HelpLine = Nothing
        Me.mskCotizacion.hWnd = 0
        Me.mskCotizacion.Location = New System.Drawing.Point(390, 148)
        Me.mskCotizacion.Mask = " "
        Me.mskCotizacion.MaxReal = 1.0E+11!
        Me.mskCotizacion.MinReal = 0.0!
        Me.mskCotizacion.Name = "mskCotizacion"
        Me.mskCotizacion.Nullable = False
        Me.mskCotizacion.Separator = True
        Me.mskCotizacion.Size = New System.Drawing.Size(147, 20)
        Me.mskCotizacion.StringIndex = CType(0, Short)
        Me.mskCotizacion.TabIndex = 7
        Me.mskCotizacion.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskCotizacion, "")
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
        Me._lblEtiqueta_6.Location = New System.Drawing.Point(10, 85)
        Me._lblEtiqueta_6.Name = "_lblEtiqueta_6"
        Me.COBISResourceProvider.SetResourceID(Me._lblEtiqueta_6, "501042")
        Me._lblEtiqueta_6.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me._lblEtiqueta_6.Size = New System.Drawing.Size(105, 13)
        Me._lblEtiqueta_6.TabIndex = 8
        Me._lblEtiqueta_6.Text = "*Número de cheque:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me._lblEtiqueta_6, "")
        '
        'lblCotizacion
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblCotizacion, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblCotizacion, False)
        Me.lblCotizacion.AutoSize = True
        Me.lblCotizacion.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblCotizacion, "Default")
        Me.lblCotizacion.ForeColor = System.Drawing.Color.Navy
        Me.lblCotizacion.Location = New System.Drawing.Point(287, 148)
        Me.lblCotizacion.Name = "lblCotizacion"
        Me.COBISResourceProvider.SetResourceID(Me.lblCotizacion, "5269")
        Me.lblCotizacion.Size = New System.Drawing.Size(63, 13)
        Me.lblCotizacion.TabIndex = 20
        Me.lblCotizacion.Text = "*Cotización:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblCotizacion, "")
        '
        'mskValorConvertido
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValorConvertido, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValorConvertido, False)
        Me.mskValorConvertido.BackColor = System.Drawing.SystemColors.Window
        Me.mskValorConvertido.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskValorConvertido.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskValorConvertido, "Default")
        Me.mskValorConvertido.Cuantas = 0
        Me.mskValorConvertido.DateString = "_.$"
        Me.mskValorConvertido.DateSybase = Nothing
        Me.mskValorConvertido.Decimals = CType(2, Short)
        Me.mskValorConvertido.Enabled = False
        Me.mskValorConvertido.Errores = CType(0, Short)
        Me.mskValorConvertido.Fin = 0
        Me.mskValorConvertido.FormattedText = Nothing
        Me.mskValorConvertido.HelpLine = Nothing
        Me.mskValorConvertido.hWnd = 0
        Me.mskValorConvertido.Location = New System.Drawing.Point(121, 148)
        Me.mskValorConvertido.Mask = " "
        Me.mskValorConvertido.MaxReal = 1.0E+11!
        Me.mskValorConvertido.MinReal = 0.0!
        Me.mskValorConvertido.Name = "mskValorConvertido"
        Me.mskValorConvertido.Nullable = False
        Me.mskValorConvertido.Separator = True
        Me.mskValorConvertido.Size = New System.Drawing.Size(147, 20)
        Me.mskValorConvertido.StringIndex = CType(0, Short)
        Me.mskValorConvertido.TabIndex = 6
        Me.mskValorConvertido.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValorConvertido, "")
        '
        'mskValor
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.mskValor, False)
        Me.COBISViewResizer.SetAutoResize(Me.mskValor, False)
        Me.mskValor.BackColor = System.Drawing.SystemColors.Window
        Me.mskValor.ClipMode = COBISCorp.Framework.UI.Components.ENUM_CLIPMODE.Include_Literals_on_cut_copy
        Me.mskValor.ClipText = "0.00"
        Me.COBISStyleProvider.SetControlStyle(Me.mskValor, "Default")
        Me.mskValor.Cuantas = 0
        Me.mskValor.DateString = "_.$"
        Me.mskValor.DateSybase = Nothing
        Me.mskValor.Decimals = CType(2, Short)
        Me.mskValor.Errores = CType(0, Short)
        Me.mskValor.Fin = 0
        Me.mskValor.FormattedText = Nothing
        Me.mskValor.HelpLine = Nothing
        Me.mskValor.hWnd = 0
        Me.mskValor.Location = New System.Drawing.Point(121, 130)
        Me.mskValor.Mask = " "
        Me.mskValor.MaxReal = 1.0E+11!
        Me.mskValor.MinReal = 0.0!
        Me.mskValor.Name = "mskValor"
        Me.mskValor.Nullable = False
        Me.mskValor.Separator = True
        Me.mskValor.Size = New System.Drawing.Size(147, 20)
        Me.mskValor.StringIndex = CType(0, Short)
        Me.mskValor.TabIndex = 5
        Me.mskValor.TextAlign = System.Windows.Forms.HorizontalAlignment.Right
        Me.COBISViewResizer.SetWidthRelativeTo(Me.mskValor, "")
        '
        'lblvalorCon
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.lblvalorCon, False)
        Me.COBISViewResizer.SetAutoResize(Me.lblvalorCon, False)
        Me.lblvalorCon.AutoSize = True
        Me.lblvalorCon.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.lblvalorCon, "Default")
        Me.lblvalorCon.ForeColor = System.Drawing.Color.Navy
        Me.lblvalorCon.Location = New System.Drawing.Point(10, 148)
        Me.lblvalorCon.Name = "lblvalorCon"
        Me.COBISResourceProvider.SetResourceID(Me.lblvalorCon, "5268")
        Me.lblvalorCon.Size = New System.Drawing.Size(92, 13)
        Me.lblvalorCon.TabIndex = 19
        Me.lblvalorCon.Text = "*Valor Convertido:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.lblvalorCon, "")
        '
        'Label1
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label1, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label1, False)
        Me.Label1.AutoSize = True
        Me.Label1.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label1, "Default")
        Me.Label1.ForeColor = System.Drawing.Color.Navy
        Me.Label1.Location = New System.Drawing.Point(10, 110)
        Me.Label1.Name = "Label1"
        Me.COBISResourceProvider.SetResourceID(Me.Label1, "5209")
        Me.Label1.Size = New System.Drawing.Size(53, 13)
        Me.Label1.TabIndex = 14
        Me.Label1.Text = "*Moneda:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label1, "")
        '
        'Label3
        '
        Me.COBISViewResizer.SetAutoRelocate(Me.Label3, False)
        Me.COBISViewResizer.SetAutoResize(Me.Label3, False)
        Me.Label3.AutoSize = True
        Me.Label3.BackColor = System.Drawing.Color.Transparent
        Me.COBISStyleProvider.SetControlStyle(Me.Label3, "Default")
        Me.Label3.ForeColor = System.Drawing.Color.Navy
        Me.Label3.Location = New System.Drawing.Point(10, 130)
        Me.Label3.Name = "Label3"
        Me.COBISResourceProvider.SetResourceID(Me.Label3, "500030")
        Me.Label3.Size = New System.Drawing.Size(38, 13)
        Me.Label3.TabIndex = 18
        Me.Label3.Text = "*Valor:"
        Me.COBISViewResizer.SetWidthRelativeTo(Me.Label3, "")
        '
        'FTRANDetalleChequeClass
        '
        Me.COBISViewResizer.SetAutoRelocate(Me, False)
        Me.COBISViewResizer.SetAutoResize(Me, False)
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.BackColor = System.Drawing.Color.White
        Me.Controls.Add(Me.PForma)
        Me.Controls.Add(Me.TSBotones)
        Me.COBISStyleProvider.SetControlStyle(Me, "Default")
        Me.COBISStyleProvider.SetEnableStyle(Me, True)
        Me.Name = "FTRANDetalleChequeClass"
        Me.Size = New System.Drawing.Size(625, 400)
        Me.Text = "Detalle de Cheques "
        Me.COBISViewResizer.SetWidthRelativeTo(Me, "")
        Me.TSBotones.ResumeLayout(False)
        Me.TSBotones.PerformLayout()
        CType(Me.PForma, System.ComponentModel.ISupportInitialize).EndInit()
        Me.PForma.ResumeLayout(False)
        CType(Me.grdDetalle, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grdDetalle_Sheet1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GroupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.GroupBox1.ResumeLayout(False)
        Me.GroupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents COBISViewResizer As COBISCorp.eCOBIS.Commons.COBISViewResizer
    Public WithEvents COBISResourceProvider As COBISCorp.Framework.UI.Components.COBISResourceProvider
    Friend WithEvents TSBotones As System.Windows.Forms.ToolStrip
    Friend WithEvents TSBAceptar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBAgregar As System.Windows.Forms.ToolStripButton
    Friend WithEvents TSBEliminar As System.Windows.Forms.ToolStripButton
    Friend WithEvents PForma As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_0 As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_6 As System.Windows.Forms.Label
    Friend WithEvents lblCotizacion As System.Windows.Forms.Label
    Friend WithEvents lblvalorCon As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents mskCotizacion As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents mskValorConvertido As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents mskValor As COBISCorp.Framework.UI.Components.COBISMaskedInBox
    Friend WithEvents COBISStyleProvider As COBISCorp.eCOBIS.Commons.Styles.COBISStyleProvider
    Friend WithEvents GroupBox1 As Infragistics.Win.Misc.UltraGroupBox
    Friend WithEvents Label4 As System.Windows.Forms.Label
    Private WithEvents lblNoBanco As System.Windows.Forms.Label
    Private WithEvents lblNoTipo As System.Windows.Forms.Label
    Private WithEvents _lblEtiqueta_5 As System.Windows.Forms.Label
    Private WithEvents mskFechaEmi As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents txtNumCheque As System.Windows.Forms.TextBox
    Private WithEvents txtCoBanco As System.Windows.Forms.TextBox
    Private WithEvents txtCoTipo As System.Windows.Forms.TextBox
    Private WithEvents lblNoCuenta As System.Windows.Forms.Label
    Private WithEvents txtNumCuenta As System.Windows.Forms.TextBox
    Private WithEvents txtBanco As System.Windows.Forms.TextBox
    Friend WithEvents mskCuenta As COBISCorp.Framework.UI.Components.COBISMaskedTextBox
    Private WithEvents lblNoMoneda As System.Windows.Forms.Label
    Private WithEvents txtCoMoneda As System.Windows.Forms.TextBox
    Friend WithEvents grdDetalle As COBISCorp.Framework.UI.Components.COBISSpread
    Friend WithEvents grdDetalle_Sheet1 As FarPoint.Win.Spread.SheetView

End Class

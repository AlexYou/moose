[Mesh]
  type = GeneratedMesh
  dim = 2
  nx = 10
  ny = 10
  distribution = SERIAL
[]

[Variables]
  [./u]
  [../]
[]

[AuxVariables]
  [./random_nodal]
  [../]
  [./random_elemental]
    order = CONSTANT
    family = MONOMIAL
  [../]
[]

[Kernels]
  [./diff]
    type = CoefDiffusion
    variable = u
    coef = 0.1
  [../]
  [./time]
    type = TimeDerivative
    variable = u
  [../]
[]

[AuxKernels]
  [./random_nodal]
    type = RandomAux
    variable = random_nodal
  [../]
  [./random_elemental]
    type = RandomAux
    variable = random_elemental
    generate_integers = true
  [../]
[]

[BCs]
  [./left]
    type = DirichletBC
    variable = u
    boundary = left
    value = 0
  [../]
  [./right]
    type = DirichletBC
    variable = u
    boundary = right
    value = 1
  [../]
[]

[Executioner]
  # Preconditioned JFNK (default)
  type = Transient
  num_steps = 5
  dt = 0.1
  solve_type = PJFNK
  petsc_options_iname = '-pc_type -pc_hypre_type'
  petsc_options_value = 'hypre boomeramg'
[]

[Outputs]
  exodus = true
  print_perf_log = true
[]

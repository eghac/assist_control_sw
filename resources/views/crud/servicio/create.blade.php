@extends('layouts.principal')
@section('content')
<div class="clearfix"></div>
<div class="row">
  <div class="col-md-12 col-sm-12 col-xs-12">
    <div class="x_panel">
      <div class="x_title">
        <h2>Formulario Registro </h2>
        <ul class="nav navbar-right panel_toolbox">
          <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
          </li>
          <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="#">Settings 1</a>
              </li>
              <li><a href="#">Settings 2</a>
              </li>
            </ul>
          </li>
          <li><a class="close-link"><i class="fa fa-close"></i></a>
          </li>
        </ul>
        <div class="clearfix"></div>
      </div>
      <div class="x_content">
        <br />
        <form id="demo-form2"  action="{{route('servicio.store')}}" method="POST" enctype="multipart/form-data"  data-parsley-validate class="form-horizontal form-label-left">
            <input type="hidden" name="_token" id="csrf-token" value="{{ Session::token() }}" />


            <div class="form-group">
              <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cargo">Nombre Cliente <span class="required">*</span>
              </label>
              <div class="col-md-6 col-sm-6 col-xs-12">
              <select name="id_cliente" class="form-control col-md-7 col-xs-12" placeholder="seleccione una categoria">
                                         
                                          @foreach ($cliente as $c)
      
                                          <option value="{{$c->id}}">{{$c->nombre}}</option>
      
                                          @endforeach                       
                  </select>
              </div>  
              </div>


          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="nombre">Descripcion del trabajo <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="text" id="descripcion" name="descripcion" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <div class="form-group">
            <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cedula">Fecha y Hora <span class="required">*</span>
            </label>
            <div class="col-md-6 col-sm-6 col-xs-12">
              <input type="datetime-local" id="fecha_hora" name="fecha_hora" required="required" class="form-control col-md-7 col-xs-12">
            </div>
          </div>
          <div class="form-group">

              <div class="form-group">
                  <label class="control-label col-md-3 col-sm-3 col-xs-12" for="cargo">Asignar Personal <span class="required">*</span>
                  </label>
                  <div class="col-md-6 col-sm-6 col-xs-12">
                  <select name="id_personal" class="form-control col-md-7 col-xs-12" placeholder="seleccione una categoria">
                                             
                                              @foreach ($personal as $p)
          
                                              <option value="{{$p->id}}">{{$p->nombre}}</option>
          
                                              @endforeach                       
                      </select>
                  </div>  
                  </div>

          <div class="ln_solid"></div>
          <div class="form-group">
            <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <a button class="btn btn-danger" a href="<?=$_SERVER["HTTP_REFERER"]?>">Atras</a>     
              
              <button class="btn btn-primary" type="reset">Reset</button>
              <button type="submit" class="btn btn-success">Registrar</button>
            </div>
          </div>

        </form>
      </div>
    </div>
  </div>
</div>
@stop
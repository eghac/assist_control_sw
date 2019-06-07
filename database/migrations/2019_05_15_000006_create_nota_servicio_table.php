<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateNotaServicioTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $set_schema_table = 'nota_servicio';

    /**
     * Run the migrations.
     * @table nota_servicio
     *
     * @return void
     */
    public function up()
    {
        if (Schema::hasTable($this->set_schema_table)) return;
        Schema::create($this->set_schema_table, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id');
            $table->integer('id_cliente')->unsigned();
            $table->string('descripcion', 50);
            $table->dateTime('fecha_hora');
            $table->integer('id_personal')->unsigned();
            $table->integer('estado');

            $table->index(["id_cliente"], 'fk_nota_cliente');

            $table->index(["id_personal"], 'fk_nota_personal');


            $table->foreign('id_cliente', 'fk_nota_cliente')
                ->references('id')->on('cliente')
                ->onDelete('restrict')
                ->onUpdate('restrict');

            $table->foreign('id_personal', 'fk_nota_personal')
                ->references('id')->on('personal')
                ->onDelete('restrict')
                ->onUpdate('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
     public function down()
     {
       Schema::dropIfExists($this->set_schema_table);
     }
}

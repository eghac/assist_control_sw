<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateMarcadoTable extends Migration
{
    /**
     * Schema table name to migrate
     * @var string
     */
    public $set_schema_table = 'marcado';

    /**
     * Run the migrations.
     * @table marcado
     *
     * @return void
     */
    public function up()
    {
        if (Schema::hasTable($this->set_schema_table)) return;
        Schema::create($this->set_schema_table, function (Blueprint $table) {
            $table->engine = 'InnoDB';
            $table->increments('id');
            $table->integer('id_personal')->unsigned();
            $table->dateTime('fecha_hora');
            $table->integer('tipo');
            $table->integer('id_ubicacion')->unsigned();

            $table->index(["id_personal"], 'fk_marcado_personal');

            $table->index(["id_ubicacion"], 'fk_marcado_ubicacion');


            $table->foreign('id_personal', 'fk_marcado_personal')
                ->references('id')->on('personal')
                ->onDelete('restrict')
                ->onUpdate('restrict');

            $table->foreign('id_ubicacion', 'fk_marcado_ubicacion')
                ->references('id')->on('ubicacion')
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

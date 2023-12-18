package model.VO;

/**
 * Clase que representa el tipo de atributos.
 * Esta clase almacena la información relacionada con los atributos de un tipo de producto.
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class AtributosTipoVO {

    private int idAtributosTipo; // Identificador de los atributos del tipo
    private int tipoProducto; // Tipo de producto asociado a los atributos
    private String nombreAtributo; // Nombre del atributo

    /**
     * Constructor de la clase AtributosTipoVO.
     * 
     * @param idAtributosTipo Identificador de los atributos del tipo
     * @param tipoProducto Tipo de producto asociado a los atributos
     * @param nombreAtributo Nombre del atributo
     */
    public AtributosTipoVO(int idAtributosTipo, int tipoProducto, String nombreAtributo) {
        this.idAtributosTipo = idAtributosTipo;
        this.tipoProducto = tipoProducto;
        this.nombreAtributo = nombreAtributo;
    }

    /**
     * Obtiene el identificador de los atributos del tipo.
     * 
     * @return El identificador de los atributos del tipo
     */
    public int getIdAtributosTipo() {
        return idAtributosTipo;
    }

    /**
     * Establece el identificador de los atributos del tipo.
     * 
     * @param idAtributosTipo El identificador de los atributos del tipo a establecer
     */
    public void setIdAtributosTipo(int idAtributosTipo) {
        this.idAtributosTipo = idAtributosTipo;
    }

    /**
     * Obtiene el tipo de producto asociado a los atributos.
     * 
     * @return El tipo de producto asociado a los atributos
     */
    public int getTipoProducto() {
        return tipoProducto;
    }

    /**
     * Establece el tipo de producto asociado a los atributos.
     * 
     * @param tipoProducto El tipo de producto a establecer
     */
    public void setTipoProducto(int tipoProducto) {
        this.tipoProducto = tipoProducto;
    }

    /**
     * Obtiene el nombre del atributo.
     * 
     * @return El nombre del atributo
     */
    public String getNombreAtributo() {
        return nombreAtributo;
    }

    /**
     * Establece el nombre del atributo.
     * 
     * @param nombreAtributo El nombre del atributo a establecer
     */
    public void setNombreAtributo(String nombreAtributo) {
        this.nombreAtributo = nombreAtributo;
    }
}
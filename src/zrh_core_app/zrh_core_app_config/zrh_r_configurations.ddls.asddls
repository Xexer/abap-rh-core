@EndUserText.label: 'RH: Configuration Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'ConfigAll'
  }
}
define root view entity ZRH_R_ConfigurationS
  as select from    I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZRH_I_CONFIGURATION'
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZRH_I_Configuration        as _Config
{
      @UI.facet: [ {
        id: 'Transport',
        purpose: #STANDARD,
        type: #IDENTIFICATION_REFERENCE,
        label: 'Transport',
        position: 1 ,
        hidden: #(HideTransport)
      }, {
        id: 'ZRH_I_Configuration',
        purpose: #STANDARD,
        type: #LINEITEM_REFERENCE,
        label: 'RH: Configuration',
        position: 2 ,
        targetElement: '_Config'
      } ]
      @UI.lineItem: [ {
        position: 1
      } ]
  key 1                                            as SingletonID,
      _Config,
      @UI.hidden: true
      I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
      @ObjectModel.text.association: '_ABAPTransportRequestText'
      @Consumption.semanticObject: 'CustomizingTransport'
      cast( '' as sxco_transport)                  as TransportRequestID,
      _ABAPTransportRequestText,
      @UI.hidden: true
      cast( 'X' as abap_boolean preserving type)   as HideTransport
}
where
  I_Language.Language = $session.system_language

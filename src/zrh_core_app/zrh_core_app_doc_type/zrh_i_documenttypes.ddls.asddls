@EndUserText.label: 'Document Type Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'DocumentTypeAll'
  }
}
define root view entity ZRH_I_DocumentTypeS
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZRH_I_DOCUMENTTYPE'
  association [0..*] to I_ABAPTransportRequestText as _ABAPTransportRequestText on $projection.TransportRequestID = _ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZRH_I_DocumentType as _DocumentType
{
  @UI.facet: [ {
    id: 'ZRH_I_DocumentType', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Document Type', 
    position: 1 , 
    targetElement: '_DocumentType'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _DocumentType,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  @UI.hidden: true
  cast( '' as sxco_transport) as TransportRequestID,
  _ABAPTransportRequestText
}
where I_Language.Language = $session.system_language

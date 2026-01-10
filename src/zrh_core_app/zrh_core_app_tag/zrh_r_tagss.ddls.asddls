@EndUserText.label: 'Tags Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'TagsAll'
  }
}
define root view entity ZRH_R_TagsS
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZRH_I_TAGS'
  composition [0..*] of ZRH_I_Tags as _Tags
{
  @UI.facet: [ {
    id: 'ZRH_I_Tags', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'Tags', 
    position: 1 , 
    targetElement: '_Tags'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _Tags,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax
}
where I_Language.Language = $session.system_language

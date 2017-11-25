
#import "iPadLocalizationViewController.h"
#import "FLXSEmployee.h"


@interface iPadLocalizationViewController ()

@end

@implementation iPadLocalizationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.flxsDataGrid.delegate = self;
    
    
    [self buildGrid:self.flxsDataGrid FromXmlResource:@"FLXSLocalization"];
    self.flxsDataGrid.dataProviderFLXS = [FLXSEmployee employees] ;
}
-(NSString*)CustomMatchFilterControl_getFullName:(FLXSEmployee *)item :(FLXSFlexDataGridColumn *)col{
    return [[item.firstName stringByAppendingString:@" "] stringByAppendingString:item.lastName];
}
-(void)localization_creationCompleteHandler:(NSNotification*)ns{
    //These would go into a global init file or something

      FLXSFilter.ALL_ITEM = @"tous";
      FLXSConstants.MCS_LBL_TITLE_TEXT=@"Trier la colonne multi";
    FLXSConstants.MCS_LBL_TITLE_TEXT =@"Trier la colonne multi";
    FLXSConstants.MCS_LBL_HEADER_TEXT =@"S'il vous plaît spécifier l'ordre de tri et de la direction des colonnes que vous souhaitez trier par:";
    FLXSConstants.MCS_LBL_SORT_BY_TEXT =@"Trier par:";
    FLXSConstants.MCS_LBL_THEN_BY_TEXT =@"Then par:";
    FLXSConstants.MCS_RBN_ASCENDING_LABEL =@"ascendant";
    FLXSConstants.MCS_RBN_DESCENDING_LABEL =@"descendant";
    FLXSConstants.MCS_BTN_CLEAR_ALL_LABEL =@"effacer tout";
    FLXSConstants.MCS_BTN_APPLY_LABEL =@"appliquer";
    FLXSConstants.MCS_BTN_CANCEL_LABEL =@"annuler";
    
    FLXSConstants.SETTINGS_COLUMNS_TO_SHOW =@"Colonnes à afficher";
    FLXSConstants.SAVE_SETTINGS_TITLE =@"Les préférences que vous définissez ci-dessous sont conservées lors de cette grille est chargé dans l'avenir:";
    FLXSConstants.SAVE_SETTINGS_PREFERENCE_NAME =@"Nom de l'option:";
    FLXSConstants.SAVE_SETTINGS_ORDER_OF_COLUMNS =@"Ordre des colonnes";
    FLXSConstants.SAVE_SETTINGS_VISIBILITY_OF_COLUMNS =@"Visibilité des colonnes";
    FLXSConstants.SAVE_SETTINGS_WIDTHS_OF_COLUMNS =@"Largeurs de colonnes";
    FLXSConstants.SAVE_SETTINGS_FILTER_CRITERIA =@"Critères de filtrage";
    FLXSConstants.SAVE_SETTINGS_SORT_SETTINGS =@"Réglages Trier";
    FLXSConstants.SAVE_SETTINGS_SCROLL_POSITIONS =@"positions de défilement";
    FLXSConstants.SAVE_SETTINGS_FILTER_AND_FOOTER_VISIBILITY =@"Visiblité filtre et pied de page";
    FLXSConstants.SAVE_SETTINGS_RECORDS_PER_PAGE =@"Enregistrements par page";
    FLXSConstants.SAVE_SETTINGS_PRINT_SETTINGS =@"Paramètres d'impression";
    FLXSConstants.SAVE_SETTINGS_REMOVE_ALL_SAVED_PREFERENCES =@"Supprimer toutes les préférences sauvegardées";
    FLXSConstants.SAVE_SETTINGS_CLEAR_SAVED_PREFERENCES =@"Claires Préférences sauvegardées";
    FLXSConstants.SAVE_SETTINGS_SAVE_PREFERENCES =@"Enregistrer les préférences";
    FLXSConstants.SAVE_SETTINGS_CANCEL =@"annuler";

    FLXSConstants.SETTINGS_COLUMNS_TO_SHOW =@"Colonnes à afficher";
    FLXSConstants.SETTINGS_SHOW_FOOTERS =@"montrer pieds de page";
    FLXSConstants.SETTINGS_SHOW_FILTER =@"Filtrer";
    FLXSConstants.SETTINGS_RECORDS_PER_PAGE =@"Enregistrements par page";
    FLXSConstants.SETTINGS_APPLY =@"Appliquer";
    FLXSConstants.SETTINGS_CANCEL =@"Annuler";
    
    FLXSConstants.OPEN_SETTINGS_DEFAULT =@"Par défaut?";
    FLXSConstants.OPEN_SETTINGS_PREFERENCE_NAME =@"Nom de l'option";
    FLXSConstants.OPEN_SETTINGS_DELETE =@"effacer";
    FLXSConstants.OPEN_SETTINGS_APPLY =@"appliquer";
    FLXSConstants.OPEN_SETTINGS_REMOVE_ALL_SAVED_PREFERENCES =@"Supprimer toutes les préférences sauvegardées";
    FLXSConstants.OPEN_SETTINGS_SAVE_CHANGES =@"Enregistrer les modifications";
    FLXSConstants.OPEN_SETTINGS_CLOSE =@"fermer";

    FLXSConstants.PGR_BTN_WORD_TOOLTIP =@"Exporter vers Word";
    FLXSConstants.PGR_BTN_EXCEL_TOOLTIP =@"Exporter vers Excel";
    FLXSConstants.PGR_BTN_PDF_TOOLTIP =@"Imprimer au format PDF";
    FLXSConstants.PGR_BTN_PRINT_TOOLTIP =@"imprimer";
    FLXSConstants.PGR_BTN_CLEAR_FILTER_TOOLTIP =@"Effacer le filtre";
    FLXSConstants.PGR_BTN_RUN_FILTER_TOOLTIP =@"Exécuter Filtrer";
    FLXSConstants.PGR_BTN_FILTER_TOOLTIP =@"Afficher / Masquer filtre";
    FLXSConstants.PGR_BTN_FOOTER_TOOLTIP =@"Afficher / Masquer Footer";
    FLXSConstants.PGR_BTN_SAVE_PREFS_TOOLTIP =@"Enregistrer les préférences";
    FLXSConstants.PGR_BTN_PREFERENCES_TOOLTIP =@"préférences";
    FLXSConstants.PGR_BTN_COLLAPSE_ALL_TOOLTIP =@"Réduire tout";
    FLXSConstants.PGR_BTN_EXP_ALL_TOOLTIP =@"Développer tout";
    FLXSConstants.PGR_BTN_EXP_ONE_UP_TOOLTIP =@"Développer un Level Up";
    FLXSConstants.PGR_BTN_EXP_ONE_DOWN_TOOLTIP =@"Développer un niveau plus bas";
    FLXSConstants.PGR_BTN_MCS_TOOLTIP =@"Tri sur plusieurs colonnes";
    
    FLXSConstants.PGR_BTN_FIRST_PAGE_TOOLTIP =@"Première page";
    FLXSConstants.PGR_BTN_PREV_PAGE_TOOLTIP =@"page précédente";
    FLXSConstants.PGR_BTN_NEXT_PAGE_TOOLTIP =@"page suivante";
    FLXSConstants.PGR_BTN_LAST_PAGE_TOOLTIP =@"Dernière page";
    FLXSConstants.PGR_LBL_GOTO_PAGE_TEXT =@"Aller à la page:";
    
    FLXSConstants.PGR_ITEMS=@"Articles";
    FLXSConstants.PGR_TO=@"à";
    FLXSConstants.PGR_OF=@"de";
    FLXSConstants.PGR_PAGE=@"page";
    

    FLXSConstants.SELECTED_RECORDS=@"enregistrements sélectionnés";
    FLXSConstants.NONE_SELECTED=@"Aucune sélection";
    
    
    FLXSConstants.EXP_LBL_TITLE_TEXT=@"options d'exportation";
    FLXSConstants.EXP_RBN_CURRENT_PAGE_LABEL=@"page courante" ;
    FLXSConstants.EXP_RBN_ALL_PAGES_LABEL=@"toutes les pages" ;
    FLXSConstants.EXP_RBN_SELECT_PGS_LABEL=@"spécifiez Pages" ;
    FLXSConstants.EXP_LBL_EXPORT_FORMAT_TEXT=@"Export au format:" ;
    FLXSConstants.EXP_LBL_COLS_TO_EXPORT_TEXT=@"Colonnes à exporter:" ;
    FLXSConstants.EXP_BTN_EXPORT_LABEL=@"exporter" ;
    FLXSConstants.EXP_BTN_CANCEL_LABEL=@"annuler" ;
    
    FLXSConstants.PPRV_LBL_TITLE_TEXT =@"options d'impression";
    FLXSConstants.PRT_LBL_TITLE_TEXT =@"options d'impression";
    FLXSConstants.PRT_LBL_PRT_OPTIONS_TEXT=@"options d'impression:";
    FLXSConstants.PRT_RBN_CURRENT_PAGE_LABEL =@"page courante" ;
    FLXSConstants.PRT_RBN_ALL_PAGES_LABEL=@"toutes les pages" ;
    FLXSConstants.PRT_RBN_SELECT_PGS_LABEL  =@"spécifiez Pages" ;
    FLXSConstants.PRT_CB_PRVW_PRINT_LABEL =@"Aperçu avant impression" ;
    FLXSConstants.PRT_LBL_COLS_TO_PRINT_TEXT =@"Colonnes à imprimer:" ;
    FLXSConstants.PRT_BTN_PRINT_LABEL =@"imprimer" ;
    FLXSConstants.PRT_BTN_CANCEL_LABEL  =@"annuler" ;
    
    FLXSConstants.PPRV_LBL_PG_SIZE_TEXT =@"Taille de la page:";
    FLXSConstants.PPRV_LBL_LAYOUT_TEXT =@"Mise en page:";
    FLXSConstants.PPRV_LBL_COLS_TEXT =@"colonnes:";
    FLXSConstants.PPRV_CB_PAGE_HDR_LABEL =@"tête de page";
    FLXSConstants.PPRV_CB_PAGE_FTR_LABEL =@"Pied de page";
    FLXSConstants.PPRV_CB_RPT_FTR_LABEL =@"tête de l'état";
    FLXSConstants.PPRV_CB_RPT_HDR_LABEL =@"Rapport pied de page";
    FLXSConstants.PPRV_BTN_PRT_LABEL =@"imprimer";
    FLXSConstants.PPRV_BTN_CANCEL_LABEL =@"annuler";
    FLXSConstants.PPRV_LBL_SETTINGS_1_TEXT =@"Remarque: Modification de la taille de page ou mise en page ne ​​mettra à jour l'aperçu, pas la réelle impression.";
    FLXSConstants.PPRV_LBL_SETTINGS_2_TEXT =@"S'il vous plaît régler la Taille de la page / Mise en page sur Paramètres de l'imprimante via la boîte de dialogue Imprimer qui sera affiché lorsque vous imprimez.";
    FLXSConstants.PPRV_BTN_PRT_1_LABEL =@"imprimer";
    FLXSConstants.PPRV_BTN_CANCEL_1_LABEL =@"annuler";
}

- (void)viewDidUnload {
    [self setFlxsDataGrid:nil];
    [super viewDidUnload];
}
@end

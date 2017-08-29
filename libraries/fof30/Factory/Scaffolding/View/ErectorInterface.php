<?php
/**
 * @package     FOF
 * @copyright   2010-2017 Nicholas K. Dionysopoulos / Akeeba Ltd
 * @license     GNU GPL version 2 or later
 */

namespace FOF30\Factory\Scaffolding\View;

use FOF30\View\DataView\Html;

interface ErectorInterface
{
	/**
	 * Construct the erector object
	 *
	 * @param   Builder  $parent   The parent builder
	 * @param   Html     $view     The controller we're erecting a scaffold against
	 * @param   string   $viewName The view name for this view
	 * @param   string   $viewType The view type for this view
	 */
	public function __construct(Builder $parent, Html $view, $viewName, $viewType);

	/**
	 * Erects a scaffold. It then uses the parent's methods to assign the erected scaffold.
	 *
	 * @return  void
	 */
	public function build();

    /**
     * @return string
     */
    public function getSection();

    /**
     * @param string $section
     */
    public function setSection($section);
}